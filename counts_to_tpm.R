#!/usr/bin/env Rscript

# A script for RPKM, FPKM and TPM transformation from read counts (featureCounts)
# Annotations using ensembl datasets
# Author: PJ Wu
# Date: 2020-08-31

args = commandArgs(trailingOnly=TRUE)
# If TRUE, only arguments after --args are returned

# test if there is at least one argument
# if not, return error
if (length(args)==0){
    stop("At least one argument must be supplied", call.=FALSE)
}else if (length(args)>=1){
    # set annotation species and output file name
    if (args[2] == "human"){
        ens_dataset = "hsapiens_gene_ensembl"
    }else if (args[2] == "mouse"){
        ens_dataset = "mmusculus_gene_ensembl"
    }else{
        ens_dataset = "hsapiens_gene_ensembl" 
    }
    print(paste("Annotation specie is set to: ", ens_dataset))
    args[3] = "GeneExprssion.txt"
    print(paste("Output filename: ", args[3]))
}

# Main programme
library("tidyverse")

rpkm = function(counts, lengths){
    scaling = sum(counts)/1e6
    rpm = counts/scaling # sequencing depth normalization
    rpkm = rpm/lengths*1e3 # divide the rpm by the length(kb) of gene
    return(rpkm)
}

tpm = function(counts, lengths){
    rpk = counts/(lengths/1e3) # normalize for gene length(kb)
    scaling = sum(rpk)/1e6 # per million scaling factor
    tpm = rpk/scaling # normalize for sequencing depth: divide the value by the per million scaling factor
    return(tpm)
}

df = read.table(args[1], sep = "\t", header = TRUE)
samples = colnames(df)[-c(1:6)]
samples_new = str_replace_all(samples, c("mapped_reads."="", "_sorted.bam" = ".counts"))
df_re = rename_at(df, vars(samples), ~samples_new)
df_sub = select(df_re, -c(2:5))

for (i in samples_new){
    name_rpkm = str_replace(i, ".counts", "")
    name_rpkm = paste(name_rpkm, "rpkm", sep = ".")
    df_sub[name_rpkm] = rpkm(df_sub[i], df_sub$Length)
    name_tpm = str_replace(i, ".counts", "")
    name_tpm = paste(name_tpm, "tpm", sep = ".")
    df_sub[name_tpm] = tpm(df_sub[i], df_sub$Length)
}   

# Add additional gene anotations
library("biomaRt")
ensembl = useMart("ensembl", dataset = ens_dataset)
anno = getBM(attributes = c("ensembl_gene_id", "external_gene_name", "gene_biotype"), mart = ensembl)
df_sub_anno = left_join(df_sub, anno, by = c("Geneid" = "ensembl_gene_id"), keep = FALSE) %>%
    rename("Gene_symbol" = "external_gene_name", "Gene_biotype" = "gene_biotype") %>%
    dplyr::select(c("Geneid", "Gene_symbol", "Gene_biotype", everything()))

write.table(df_sub_anno, file = args[3], sep= "\t", row.names = FALSE, fileEncoding = "utf-8")
