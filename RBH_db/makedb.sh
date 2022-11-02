#!/bin/bash
echo ..... BUILDING DATABASES  .....
/anaconda3/bin/makeblastdb -in /Users/stubbf02/Fx_Stubbe/Projects/Angy/RBH/tProteomes/Abortus2308_tprot.fasta -dbtype prot -parse_seqids -out /Users/stubbf02/Fx_Stubbe/Projects/Angy/RBH/RBH_db/Abortus2308
/anaconda3/bin/makeblastdb -in /Users/stubbf02/Fx_Stubbe/Projects/Angy/RBH/tProteomes/B_henselae_tprot.fasta -dbtype prot -parse_seqids -out /Users/stubbf02/Fx_Stubbe/Projects/Angy/RBH/RBH_db/B_henselae
/anaconda3/bin/makeblastdb -in /Users/stubbf02/Fx_Stubbe/Projects/Angy/RBH/tProteomes/C_crescentus_tprot.fasta -dbtype prot -parse_seqids -out /Users/stubbf02/Fx_Stubbe/Projects/Angy/RBH/RBH_db/C_crescentus
/anaconda3/bin/makeblastdb -in /Users/stubbf02/Fx_Stubbe/Projects/Angy/RBH/tProteomes/Melitensis16M_tprot.fasta -dbtype prot -parse_seqids -out /Users/stubbf02/Fx_Stubbe/Projects/Angy/RBH/RBH_db/Melitensis16M
/anaconda3/bin/makeblastdb -in /Users/stubbf02/Fx_Stubbe/Projects/Angy/RBH/tProteomes/O_anthropi_tprot.fasta -dbtype prot -parse_seqids -out /Users/stubbf02/Fx_Stubbe/Projects/Angy/RBH/RBH_db/O_anthropi
/anaconda3/bin/makeblastdb -in /Users/stubbf02/Fx_Stubbe/Projects/Angy/RBH/tProteomes/S.meliloti_tprot.fasta -dbtype prot -parse_seqids -out /Users/stubbf02/Fx_Stubbe/Projects/Angy/RBH/RBH_db/S.meliloti
echo ..... DATABASES ARE READY .....
