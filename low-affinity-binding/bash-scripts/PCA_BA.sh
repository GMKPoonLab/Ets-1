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
		#rms to first frame
	rms first :4-101@C,CA,N,O
		#construct matrix
	matrix name matc covar :4-101@C,CA,N,O
	run
	runanalysis diagmatrix matc out PCA.evecs.dat name diagmodes vecs 5 
	rms first :4-101@C,CA,N,O
	projection evecs diagmodes out PCA.project.dat beg 1 end 5 :4-101@C,CA,N,O
	run
	quit
EOF

$AMBERHOME/amber16/bin/cpptraj -i PCA.ptraj

wait

rm PCA.ptraj

wait

cat >PCA.ptraj<<EOF
	parm /HA1/*.prmtop
	parmstrip !:4-101@C,CA,N,O
	readdata PCA.evecs.dat
	modes eigenval name PCA.evecs.dat out PCA.eigenval.dat
	runanalysis modes name PCA.evecs.dat trajout PC1_LA.nc trajoutmask :4-101@C,CA,N,O pcmin VAR pcmax VAR tmode 1
	runanalysis modes name PCA.evecs.dat trajout PC2b.nc trajoutmask :4-101@C,CA,N,O pcmin VAR pcmax VAR tmode 2
EOF

$AMBERHOME/amber16/bin/cpptraj -i PCA.ptraj

wait

rm PCA.ptraj
