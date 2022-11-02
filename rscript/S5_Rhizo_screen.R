###
# Subset GGDEF entries from Melitensis16M
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
p.Rhizo <- paste(p.main, "./Rhizo_screen/", sep = "")

#Inputs
tprot.f <- list.files(path = p.proteomes, pattern = "_tprot.fasta") 
tables.f <- list.files(p.Ortho , pattern = ".csv")



#2) Get the melitensis
# -------------- # # -------------- # # -------------- #

#Prepare the output file
output_file <- paste(p.Rhizo, "Rhizo_Screen_Melitensis.txt", sep = "")

#seqnames 
seq_name <- c("BME_RS07245","BME_RS13385","BME_RS14615","BME_RS08600","BME_RS07585","BME_RS07270","BME_RS13420","BME_RS15100","BME_RS11750","BME_RS04625","BME_RS11625")

#table
tables <- tables.f %>% str_subset("Melitensis16M")

#Subset the chromosome data

for(j in 1:length(tables)){
  #Get the data
  output_data <- read_csv(paste(p.Ortho, tables[j], sep="")) %>% filter(Melitensis16M %in% seq_name)
  cat(paste("# Fields : ", str_c(colnames(output_data), collapse = "\t"), sep = ""), sep = "\n",file=output_file,append=TRUE)
  #Loop over the subset table
  for(i in 1:nrow(output_data)){
    cat(paste( pull(output_data[i,1]), pull(output_data[i,2]), pull(output_data[i,3]), pull(output_data[i,4]), pull(output_data[i,5]), pull(output_data[i,6]),sep = "\t"),
        sep="\n",file=output_file,append=TRUE)
  }
}

#3) Get the Abortus
# -------------- # # -------------- # # -------------- #
#Prepare the output file
output_file <- paste(p.Rhizo, "Rhizo_Screen_Abortus.txt", sep = "")

#seqnames 
seq_name <- c("BAB_RS18360","BAB_RS29290","BAB_RS30405","BAB_RS16950","BAB_RS18020","BAB_RS18335","BAB_RS29325","BAB_RS27460","BAB_RS27590")

#table
tables <- tables.f %>% str_subset("Abortus2308")

#Subset the chromosome data
for(j in 1:length(tables)){
  #Get the data
  output_data <- read_csv(paste(p.Ortho, tables[j], sep="")) %>% filter(Abortus2308 %in% seq_name)
  cat(paste("# Fields : ", str_c(colnames(output_data), collapse = "\t"), sep = ""), sep = "\n",file=output_file,append=TRUE)
  #Loop over the subset table
  for(i in 1:nrow(output_data)){
    cat(paste( pull(output_data[i,1]), pull(output_data[i,2]), pull(output_data[i,3]), pull(output_data[i,4]), pull(output_data[i,5]), pull(output_data[i,6]),sep = "\t"),
        sep="\n",file=output_file,append=TRUE)
  }
}


length(unique(vector))
vector %>% unique() %>% length()




  