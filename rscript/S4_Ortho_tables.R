###
# Get the best hit From Genome1 on Genome 2 & Genome 2 on Genome 1
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
p.proteomes <- paste(p.main, "tProteomes/", sep = "")
p.Tables <- paste(p.main, "output/tables/", sep = "")
p.Ortho <- paste(p.main, "output/ortho/", sep = "")

#Inputs
tprot.f <- list.files(path = p.proteomes, pattern = "_tprot.fasta") 
tables.f <- list.files(p.Tables , pattern = "_blast_output.csv")

#seqnames (filtering blastP)
seq_name <- tprot.f %>% str_remove("_tprot.fasta") 

#2) Match the genomes
# -------------- # # -------------- # # -------------- #
dir.create(p.Ortho)

for(G1 in seq_name ){
  seq_name_2 <- seq_name %>% str_subset(G1, negate = T)
  
  for( G2 in seq_name_2){
    
    #Match the genomes s
    t.couple <- tables.f %>% str_subset(G1)%>% str_subset(G2)
    
    #Read the tables
    t.C1 <- read_csv(paste(p.Tables, t.couple[1], sep = "" ))
    t.C2 <- read_csv(paste(p.Tables, t.couple[2], sep = "" ))
    
    #Get the names
    H1 <- t.couple[1] %>% str_remove("_blast_output.csv") %>% str_split("\\.") %>% as_vector() %>% .[1]
    H2 <- t.couple[2] %>% str_remove("_blast_output.csv") %>% str_split("\\.") %>% as_vector() %>% .[1]
    Header <- c(H1, H2, "G1.evalue", "G1.bitscore", "G1.pident", "G2.evalue", "G2.bitscore", "G2.pident" )

    
    #Prepare catching matrix
    m <- matrix(nrow = 0, ncol = length(Header) )
    colnames(m) <- Header
    
    #Prepare catching matrix
    for(i in 1:nrow(t.C1)){
      index <- which(pull(t.C2[,2]) == pull(t.C1[i,1]) & pull(t.C2[,1]) == pull(t.C1[i,2]) )
      if(is_empty(index)){
        next}else{
          if(pull(t.C1[i,2]) == pull(t.C2[index,1])){
            line <- c(pull(t.C1[i,1]), pull(t.C2[index,1]), pull(t.C1[i,11]), pull(t.C1[i,12]), pull(t.C1[i,3]), pull(t.C2[index,11]), pull(t.C2[index,12]), pull(t.C2[index,3]))
            m <- rbind(m, line)
          }else{next}
        }
    }
    m <- m %>% as_tibble()
    
    #write the output
    write_csv(m, paste(p.Ortho, H1,".", H2, ".csv", sep = ""))
  }
}







