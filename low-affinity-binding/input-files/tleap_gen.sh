#!/bin/bash

export AMBERHOME=/path/to/amber16
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$AMBERHOME/lib
source /path/to/amber16/amber.sh

	#input section
prmtop=INPUT.prmtop
inpcrd=INPUT.inpcrd
pdb=INPUT.pdb
m=0.15

cat >tleap.scrpt<<EOF
	source leaprc.DNA.OL15
	source leaprc.water.tip3p
	source leaprc.protein.ff14SB
	loadamberparams frcmod.ionsjc_tip3p
	m1 = loadpdb ${pdb}
	solvateOct m1 TIP3PBOX 10.0 iso 1.0
	saveamberparm m1 ${prmtop} ${inpcrd}
	quit
EOF

tleap -f tleap.scrpt

	#calculate volume of box to determine how much excess salt to add
cat >ptraj.vol.in<<EOF
	parm ${prmtop}
	trajin ${inpcrd}
	volume test out tvol.dat
EOF

cpptraj -i ptraj.vol.in

tvol=`awk 'NR>1{print $2}' tvol.dat` 

fvol=`python -c "print (round($tvol))"`

echo $fvol

nV=`echo "scale=50; $fvol*10^-27" | bc`

fcon=`echo "scale=50; $nV*$m*6.022*10^23" | bc`

frcon=`python -c "print (round($fcon))"`

echo $frcon

	#run final tleap with extra salt
cat >tleap.scrpt<<EOF
	source leaprc.DNA.OL15
	source leaprc.water.tip3p
	source leaprc.protein.ff14SB
	loadamberparams frcmod.ionsjc_tip3p
	m1 = loadpdb ${pdb}
	solvateOct m1 TIP3PBOX 10.0 iso 1.0
	addIons m1 Na+ 0
	addIons m1 Cl- 0
	addIonsRand m1 Na+ ${frcon} 
	addIonsRand m1 Cl- ${frcon} 
	saveamberparm m1 ${prmtop} ${inpcrd}
	savepdb m1 check_$prmtop.pdb
	quit
EOF

tleap -f tleap.scrpt

wait
	
	#clean up files

echo $frcon

rm *.scrpt
rm *.dat
rm ptraj.vol.in
rm *.*~
