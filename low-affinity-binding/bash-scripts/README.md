These are all the shell (bash) scripts used for analysis. They all assume some general level of familiarity with AMBER, and the shell enviorment. 

**Please note that the AMBERHOME variable at the beginning of each script is subject to change based on location of AMBER.**


## Files

- PCA_BA.sh (protein backbone PCA script)

  >cpptraj script (wrapped in shell) for protein backbone PCA of the four systems, and follow up analysis of the data (scree plot, and generating pseudo-trajectories of the first two PCs. Make sure to update pcmin/pcmax in second cpptraj section.

- PCA_SC.sh (protein sidechain PCA script)

  >cpptraj script (wrapped in shell) for protein sidechain PCA of the four systems, with follow up analysis (scree plot, pseudo-trajectories of the first two PCs). Make sure to update pcmin/pcmax in second cpptraj section.
    
- PCA_tot.sh (total PCA for protein script) 

  >cpptraj script (wrapped in shell) for PCA of all atoms of the protein, minus first/last three residues. Follow up analysis (scree plot, pseudo-trajectories of the first two PCs) also included. Make sure to update pcmin/pcmax in second cpptraj section.
    
- cpptraj_run.sh (cpptraj analysis script)
   
  >cpptraj script (wrapped in shell) for analzying RMSD, RMSF, water counts per residue, hydrogen bond content, distances, and atom counts around various masks. 


- run_curves+.sh
   
  >Shell script to assist in running curves+ and processing the data into easily interpetable forms. There are some specific options in the input, so please read the comments carefully. **Note- the input trajectories should only have DNA present.**
