# Worlflows of RNA-Seq analysis
* RNASeq.snake 
    
    Last update: 2019-10-21
    
    This is a RNA-Seq analysis workflow including transcripts assembly for paired-end sequencing data.
    
    It contains:  
    		
		* Reads alignment back to genome: HISAT2
        * Transcripts assembly: StringTie
        * Gene counts process for DESeq2: prepDE.py

    All you need:   
      
	  * HISAT2, samtools, StringTie, prepDE.py      
      * A sample_list.txt containing all the sample (e.g. SRR9048143) to analyse
      * An annotation file (e.g. Mus_musculus.GRCm38.96.gtf)
      * Genome index for HISAT2
      * Create a directory datasets caontianing the fastq file for analysis
      * Edit RNASeq.sanke:
          * Assign GENOME_GTF = "PATH_TO_YOUR_ANNOTATION_FILE"
          * Assign HISAT2_INDEX_PREFIX = "PATH_TO_GENOME_INDEX(contain index prefix)"

    Usage: 
        `snakemake --use-conda -p -j {threads} -s RNASeq.snake`



* RNASeq_Counts.snake
    
    Last update: 2019-10-21
    
    This is a RNA-Seq analysis workflow for raw read counts for paired-end sequencing data.
    
    It contains:          
    	
		* Reads alignment back to genome: HISAT2
        * Process of read counts: featureCounts
    
    All you need:
    	
		* HISAT2, samtools, subreads(featureCounts)
        * A sample_list.txt containing all the sample (e.g. SRR9048143) to analyse
        * An annotation file (e.g. Mus_musculus.GRCm38.96.gtf)
        * Genome index for HISAT2
        * Create a directory datasets caontianing the fastq file for analysis
        * Edit RNASeq.sanke:
			* Assign GENOME_GTF = "PATH_TO_YOUR_ANNOTATION_FILE"
			* Assign HISAT2_INDEX_PREFIX = "PATH_TO_GENOME_INDEX(contain index prefix)"

    Usage:
        `snakemake -p -j {threads} -s RNASeq_Counts.snake`
