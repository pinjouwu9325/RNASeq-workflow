# Workflows for RNA-Seq analysis

### RNASeq.snake 
 
 Last update: 2020-03-02
    
 This is a RNA-Seq analysis workflow including transcripts assembly for paired-end sequencing data.
    
 It contains:  
    
  * Reads alignment back to genome: HISAT2
  * Transcripts assembly: StringTie
  * Gene counts process for DESeq2: prepDE.py

  Environments and dependencies:
    
  * RNASeq.yml
    * snakemake (v5.7.4)
    * HISAT2    (v2.1.0)
    * samtools  (v1.9)
    * StringTie (v2.1.1)
  * py27.yml
    * python    (v2.7.15)
    
  All you need:   
           
  * Create an environment with RNASeq.yml and activate it, or use your own pacakges 
  * A sample_list.txt containing all the sample names separated by comma (e.g. SRR9048143,SRR9048144)
  * An annotation file (e.g. Mus_musculus.GRCm38.96.gtf)
  * Genome index for [HISAT2](https://ccb.jhu.edu/software/hisat2/index.shtml)
  * Put the paired fastq files of each sample into `datasets`   
  * [prepDE.py](https://ccb.jhu.edu/software/stringtie/dl/prepDE.py) file for generating counts matirx
  * Edit RNASeq.sanke:
    * Assign GENOME_GTF = "PATH_TO_YOUR_ANNOTATION_FILE"
    * Assign HISAT2_INDEX_PREFIX = "PATH_TO_GENOME_INDEX(contain index prefix)"

  Usage: 
  `snakemake --use-conda -p -j {threads} -s RNASeq.snake`



### RNASeq_Counts.snake
    
  Last update: 2019-10-24
    
  This is a RNA-Seq analysis workflow for read counting for paired-end sequencing data.
    
  It contains:          
  
  * Reads alignment back to genome: HISAT2
  * Process of read counts: featureCounts
    
  Environments and dependencies:
  
  * subread	(v2.0.0)
  * RNASeq.yml
    * snakemake (v5.7.4)
    * HISAT2    (v2.1.0)
 
  All you need:
    	
  * Create an environement with RNASeq.yml and activate it, or use your own packages
  * A sample_list.txt containing all the sample names separated by comma (e.g. SRR9048143,SRR9048144)
  * An annotation file (e.g. Mus_musculus.GRCm38.96.gtf)
  * Genome index for [HISAT2](https://ccb.jhu.edu/software/hisat2/index.shtml)
  * Put the paired fastq files of each sample into `datasets` 
  * Edit RNASeq.sanke:
    * Assign GENOME_GTF = "PATH_TO_YOUR_ANNOTATION_FILE"
    * Assign HISAT2_INDEX_PREFIX = "PATH_TO_GENOME_INDEX(contain index prefix)"

  Usage:
  `snakemake -p -j {threads} -s RNASeq_Counts.snake`
