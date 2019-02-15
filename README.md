# Ets-1
Central repository for all computational resources for Ets-1 projects, organized into folders with the requisite scripts and input files associated with each project. 


Directories are organized by project/and their associated paper, ie low-affinity-binding is the project folder for "Mechanism of cognate discrimination by the ETS-family transcription factor Ets-1".


## Directory guide:

>low-affinity-binding ("Mechanism of cognate discrimination by the ETS-family transcription factor Ets-1")
  
  ###R-scripts 

  Contains all the associated R scripts for the project (block averaging+SD). R scripts are wrapped in a shell enviorment to allow for user input.
  
  
bash-scripts
 
  Contains various analysis scripts (cpptraj and curves+) wrapped in shell enviorment. The cpptraj scripts are broken into two catagories (PCA and all other analysis), while the curves+ script is designed to run and parse the output of curves+.


input-file

  Folder containing the associated input files (topologies and input coords), along with the tleap script used to prep them.
  ###
  ###
