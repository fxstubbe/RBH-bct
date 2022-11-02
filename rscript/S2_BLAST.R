###
# Launch the Blast 
#
# Author : François-Xavier Stubbe
###

#0) Library
# -------------- # # -------------- # # -------------- #

library(seqinr)
library(magrittr)
library(tidyverse)
library(data.table)

#1) Paths and Inputs
# -------------- # # -------------- # # -------------- #

#Paths
p.main <- "/Users/stubbf02/Fx_Stubbe/Projects/Angy/RBH/"
p.database <- paste(p.main, "RBH_db/", sep = "")
p.proteomes <- paste(p.main, "tProteomes/", sep = "")
p.Blast <- paste(p.main, "RBH_Blast/", sep = "")

#Inputs
tprot.f <- list.files(path = p.proteomes, pattern = "_tprot.fasta") %>% str_remove("_tprot.fasta") 
db.f <- list.files(path = p.database, pattern = ".pin") %>% str_remove(".pin") 

#Sanity Check
cat("expected file number", length(tprot.f)*length(db.f))

#1) Lauch RBBH BLASTP 
# -------------- # # -------------- # # -------------- #

#Create directory for Blast
dir.create(p.Blast)

#Make the script
Script = paste(p.Blast,"RBH.sh", sep = "")
cat(paste("#!/bin/bash"),sep="\n",file=Script,append=TRUE)
cat(paste("echo ... ... ... ... ... ... ... ... ...", sep = ""), sep="\n", file=Script,append=TRUE)
cat(paste("echo ... RECIPROCAL BEST BLAST HIT ...", sep = ""), sep="\n", file=Script,append=TRUE)
cat(paste("echo ... ... ... ... ... ... ... ... ...", sep = ""), sep="\n", file=Script,append=TRUE)
for(i in 1:length(tprot.f)){
  cat(paste("echo Blasting ", tprot.f[i], " over tprot databases" , sep = ""), sep="\n", file=Script,append=TRUE)
  for(j in 1:length(tprot.f)){
  cat(paste("/anaconda3/bin/blastp -db ", p.database , tprot.f[j],
            " -num_threads 4 ",
            "-max_target_seqs 5 ",
            "-outfmt '7 std sgi stitle' ",
            "-evalue 0.0000001 ", 
            "-query ", p.proteomes , tprot.f[i],  "_tprot.fasta ", 
            "-out ", p.Blast, tprot.f[i],".",tprot.f[j] ,"_query_over_db_BLAST.txt",
            sep = ""), 
      sep="\n", file=Script,append=TRUE)
  }
}
cat(paste("echo ... ... ... ... ... ... ... ... ...", sep = ""), sep="\n", file=Script,append=TRUE)
cat(paste("echo ... ... BLASTP ARE DONE !!! ... ...", sep = ""), sep="\n", file=Script,append=TRUE)
cat(paste("echo ... ... ... ... ... ... ... ... ...", sep = ""), sep="\n", file=Script,append=TRUE)

#Launch the script
system(paste("sh ", p.Blast,"RBH.sh", sep = ""))

