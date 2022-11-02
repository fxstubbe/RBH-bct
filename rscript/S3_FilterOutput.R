###
# Make Blast table from Blast 
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
p.Output <- paste(p.main, "output/", sep = "")
p.Tables <- paste(p.Output, "tables/", sep = "")

#Inputs
tprot.f <- list.files(path = p.proteomes, pattern = "_tprot.fasta") 
blast_files <- list.files(p.Blast , pattern = ".txt")

#seqnames (filtering blastP)
seq_name <- tprot.f %>% str_remove("_tprot.fasta") 


#4) Filter BlastP 
# -------------- # # -------------- # # -------------- #

#Create directory
dir.create(p.Output)
dir.create(p.Tables)


for(j in 1:length(blast_files)){
  
  cat(paste(j, "/", length(blast_files), sep = ""), sep = "\n")
  
  #Read the Blast file
  RBH_blast <- fread(paste(p.Blast,blast_files[j],sep=""), sep = "\t", header=F, data.table = F, fill = T)
  
  #Get query and subject
  Inputs <- blast_files[j] %>% str_remove("_query_over_db_BLAST.txt") %>% str_split("\\.") %>% as_vector()
  
  #Prepare the Matrix
  m <- matrix(nrow = 0, ncol = 14 )
  
  #Prepare the Matrix
  
  Headers <- c("query acc.ver","subject acc.ver","% identity","alignment length","mismatches","gap opens","q. start","q. end","s. start","s. end","evalue","bit score","subject gi","subject title")  
  Headers[1] <- paste(Inputs[1], "Q.", sep = "|")
  Headers[2] <- paste(Inputs[2], "S.", sep = "|")
  colnames(m) <- Headers
  
  #Loop over the Blast file
  for(i in 1:nrow(RBH_blast)){
    if(str_starts(RBH_blast[i,],"#", negate=T)){
      line <- RBH_blast[i,] %>% str_split("\t") %>% as_vector()
      line[1] <- line[1] %>% str_split("\\|") %>% as_vector() %>% .[1]
      line[2] <- line[2] %>% str_split("\\|") %>% as_vector() %>% .[1]
      m <- rbind(m, line)
    }
  }
  
  #Clean the table 
  m <- m %>% as_tibble() %>% select(-c(13,14))
  
  #Keep alignment >50 AA
  #m <- m %>% filter (`alignment length` >= 50) 
  
  #Get the best bit score
  m <- m %>% group_by(pull(m[,1])) %>%slice(which.max(`bit score`)) 

  
  #Write the output
  write_csv(m[, c(1:12)], paste(p.Tables, Inputs[1], ".",  Inputs[2],"_blast_output.csv", sep = "" ))
  
}


          