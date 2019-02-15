Input files (prmtop/inpcrd, script for prepping tleap, etc) for running the simulations. 

## Files

- tleap_run.sh
 
 >Shell script for running tleap. Assumes 10 angstrom water box and 0.15 M salt.
  
 - Various prmtop/inpcrd
  
  >Assorted prmtop/inpcrd files for each system of Ets-1 on a 23 bp DNA of differing sequences prepped from the tleap script.
    
    - Ets-1_HA = Ets-1 + high-affinity DNA
    - Ets-1_LA = Ets-1 + low-affinity DNA
    - Ets-1_NS = Ets-1 + nonspecific DNA
    - Ets-1_UB = unbound Ets-1

    - DNA_HA = high-affinty DNA
    - DNA_LA = low-affinity DNA
    - DNA_NS = nonspecific DNA
