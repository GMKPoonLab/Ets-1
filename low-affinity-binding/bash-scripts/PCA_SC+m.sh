#!/bin/bash

export AMBERHOME=/path/to/amber16
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$AMBERHOME/lib
source $AMBERHOME/amber16/amber.sh

cat >PCA.ptraj<<EOF
		#load coordinates for different data sets
	parm /HA1/*.prmtop [HA1]
	parmstrip :WAT,Cl-,Na+ parm [HA1]
	trajin /WT1/pca.nc 1 last 1 parm [HA1]
	parm /HA2/*.prmtop [HA2]
	parmstrip :WAT,Cl-,Na+ parm [HA2]
	trajin /HA2/pca.nc 1 last 1 parm [HA2]
	parm /HA3/*.prmtop [HA3]
	parmstrip :WAT,Cl-,Na+ parm [HA3]
	trajin /HA3/pca.nc 1 last 1 parm [HA3]
	parm /LA1/*.prmtop [LA1]
	parmstrip :WAT,Cl-,Na+ parm [LA1]
	trajin /LA1/pca.nc 1 last 1 parm [LA1]
	parm /LA2/*.prmtop [LA2]
	parmstrip :WAT,Cl-,Na+ parm [LA2]
	trajin /LA2/pca.nc 1 last 1 parm [LA2]
	parm /LA3/*.prmtop [LA3]
	parmstrip :WAT,Cl-,Na+ parm [LA3]
	trajin /LA3/pca.nc 1 last 1 parm [LA3]
	parm /NS1/*.prmtop [NS1]
	parmstrip :WAT,Cl-,Na+ parm [NS1]
	trajin /NS1/pca.nc 1 last 1 parm [NS1]
	parm /NS2/*.prmtop [NS2]
	parmstrip :WAT,Cl-,Na+ parm [NS2]
	trajin /NS2/pca.nc 1 last 1 parm [NS2]
	parm /NS3/*.prmtop [NS3]
	parmstrip :WAT,Cl-,Na+ parm [NS3]
	trajin /NS3/pca.nc 1 last 1 parm [NS3]
	parm /UB1/*.prmtop [ub1]
	parmstrip :WAT,Cl-,Na+ parm [ub1]
	trajin /UB1/pca.nc 1 last 1 parm [ub1]
	parm /UB2/*.prmtop [ub2]
	parmstrip :WAT,Cl-,Na+ parm [ub2]
	trajin /UB2/pca.nc 1 last 1 parm [ub2]
	parm /UB3/*.prmtop [ub3]
	parmstrip :WAT,Cl-,Na+ parm [ub3]
	trajin /UB3/pca.nc 1 last 1 parm [ub3]
	parm /Q336N/*.prmtop [336N]
	parmstrip :WAT,Cl-,Na+ parm [336N]
	trajin /Q336N/pca.nc 1 last 2 parm [336N]
	parm /Q336E/*.prmtop [Q336E]
	parmstrip :WAT,Cl-,Na+ parm [Q336E]
	trajin /Q336E/pca.nc 1 last 1 parm [Q336E]
	parm /Q336L/*.prmtop [Q336L]
	parmstrip :WAT,Cl-,Na+ parm [Q336L]
	trajin /Q336L/pca.nc 1 last 2 parm [Q336L]
	parm /Q336A/*.prmtop [336A]
	parmstrip :WAT,Cl-,Na+ parm [336A]
	trajin /Q336A/pca.nc 1 last 1 parm [336A]
	parm /E343L/*.prmtop [E343L]
	parmstrip :WAT,Cl-,Na+ parm [E343L]
	trajin /E343L/pca.nc 1 last 2 parm [E343L]
	parm /E343Q/*.prmtop [E343Q]
	parmstrip :WAT,Cl-,Na+ parm [E343Q]
	trajin /E343Q/pca.nc 1 last 1 parm [E343Q]
	rms first :5-10,12-101&!@C,CA,N,O,H=
	matrix name matc covar :5-10,12-101&!@C,CA,N,O,H=
	run
	runanalysis diagmatrix matc out PCA.evecs.dat name diagmodes vecs 5  
	rms first :5-10,12-101&!@C,CA,N,O,H=
	projection evecs diagmodes out PCA.project.dat beg 1 end 5 :5-10,12-101&!@C,CA,N,O,H=
	run
	quit
EOF

$AMBERHOME/amber16/bin/cpptraj -i PCA.ptraj

wait

rm PCA.ptraj

wait

cat >PCA.ptraj<<EOF
	parm /HA1/*.prmtop
	parmstrip :WAT,Na+,Cl-
	parmstrip :102-150
	parmstrip :1-3
	parmstrip @C,CA,N,O,H=
	readdata PCA.evecs.dat
	modes eigenval name PCA.evecs.dat out PCA.eigenval.dat
	runanalysis modes name PCA.evecs.dat trajout PC1.nc trajoutmask :4-101&!@C,CA,N,O,H= pcmin -12 pcmax -6 tmode 1
	runanalysis modes name PCA.evecs.dat trajout PC2.nc trajoutmask :4-101@C,CA,N,O pcmin -13 pcmax 5 tmode 2
EOF

$AMBERHOME/amber16/bin/cpptraj -i PCA.ptraj

wait

rm PCA.ptraj
