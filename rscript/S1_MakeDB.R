###
# Make the databses
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

#Inputs
tprot.f <- list.files(path = p.proteomes, pattern = "_tprot.fasta") %>% str_remove("_tprot.fasta") 

#IDs
seq_name <- tprot.f %>% str_remove("_tprot.fasta")  
  
#2) Make database for RBH, one by genome
# -------------- # # -------------- # # -------------- #

#Create directory for databases
dir.create(p.database)

#Make the script
Script = paste(p.database ,"makedb.sh", sep = "")
cat(paste("#!/bin/bash"),sep="\n",file=Script,append=TRUE)
cat(paste("echo ..... BUILDING DATABASES  ....." ),sep="\n",file=Script,append=TRUE)
for (i in 1:length(tprot.f)){
  cat( paste( "/anaconda3/bin/makeblastdb -in ", p.proteomes, tprot.f[i], "_tprot.fasta",
              " -dbtype prot" ,
              " -parse_seqids" ,
              " -out ", p.database ,tprot.f[i], sep = ""), 
       sep = "\n", file = Script, append = TRUE)
}
cat(paste("echo ..... DATABASES ARE READY ....." ),sep="\n",file=Script,append=TRUE)

#Launch the script
system(paste("sh ", p.database ,"makedb.sh", sep = ""))

