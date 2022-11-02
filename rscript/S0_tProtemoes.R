###
# Translate a genome into it's proteome
# Author : François-Xavier Stubbe
###
# ---------------------------- ## ---------------------------- #
# 0) Library
# ---------------------------- #

library(tidyverse)
library(seqinr)

# 1) Paths & Input
# ---------------------------- #

#Paths
p.main <- "/Users/stubbf02/Fx_Stubbe/Projects/Angy/RBH/tProteomes/"
p.ressources <- "/Users/stubbf02/Fx_Stubbe/ressources/genomes/Rhizo/"
p.genomes <- paste(p.ressources, "fasta/", sep = "")
p.gene_tables <- paste(p.ressources, "gene_tables/", sep = "")

#Genomes & annotations
f.genomes <- list.files(path = p.genomes, pattern = ".fasta")
f.annotation <- list.files(path = p.gene_tables, pattern = "_gene_table.csv")

#IDs
seq_name <- f.genomes %>% str_remove(".fasta")

#Sanity check
length(seq_name)
length(f.annotation)

# 2) Extract sequences and translate them
# ---------------------------- #

for(k in 1:length(seq_name)){
  
  #Match genome with annotation
  c.gen <- str_which(f.genomes, seq_name[k])
  c.ann <- str_which(f.annotation, seq_name[k])
  
  #read genome and annotation
  f.gen <- read.fasta(file = paste(p.genomes,f.genomes[c.gen], sep = ""),
                      seqtype = "DNA",as.string = TRUE, set.attributes = FALSE)
  f.ann <- read_csv(paste(p.gene_tables, f.annotation[c.ann], sep = ""))  
  
  #Loop over entries in the annotation file
  #Catching variables
  Seq_prot <- c() 
  Seq_header <-  c()
  
  for(i in 1:nrow(f.ann)){
    
    #Find candidate gene in genome
    gene <- f.gen[names(f.gen) == f.ann$seqname[i]] %>% str_sub(f.ann$start[i], f.ann$end[i])
    
    #If negative strand, reverse complement
    if(f.ann$strand[i] == "-"){ gene <- c2s( rev( comp( s2c(gene) ) ) ) }
    
    #Translate gene
    protein <- c2s(seqinr::translate(s2c(gene))) %>% str_replace_all("[*]", "X")
    
    #Make the header
    header <- paste(f.ann$GenBank_locus_tag[i],f.ann$feature[i],f.ann$gene_biotype[i],f.ann$protein_id[i],f.ann$name[i], f.ann$Product[i], sep = "|")
    
    #Add to list
    Seq_prot <- c(Seq_prot, protein)
    Seq_header <- c(Seq_header, header)
    
  }
  
  #Write the translated proteome
  write.fasta(sequences = as.list(Seq_prot), 
              names = Seq_header, 
              nbchar = 80, 
              file.out = paste(p.main, seq_name[k], "_tprot.fasta", sep = ""))
}


