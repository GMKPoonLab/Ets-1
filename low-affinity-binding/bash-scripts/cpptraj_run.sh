#!/bin/bash

export AMBERHOME=/path/to/amber16
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$AMBERHOME/lib
source /path/to/amber16/amber.sh

cat >analysis.ptraj<<EOF
	parm *.prmtop
		#reference to energy min structure
	reference *-EM.pdb [pdb]
	trajin combine.nc 1 last 1
		#center and reorient
	center origin :105-127
	image origin center familiar
	center origin :105-150
	image origin center familiar
	center origin :1-150
	image origin center familiar
	rms :105-127@P,O5',C5',C4',C3',O3' ref [pdb]
	rms :105-150@P,O5',C5',C4',C3',O3' ref [pdb]
	rms :1-150@C,CA,N,O,P,O5',C5',C4',C3',O3' ref [pdb]
	rms :1-150@/H ref [pdb]
		#rmsd for protein
	rms :1-104@/H nofit out rms.protein.dat ref [pdb]
      #charge charge for protein
	mask "(@NZ,NH1,NH2<@7.5)&(:105-150@OP=)" maskout rev_7.5.dat
	mask "(@NZ,NH1,NH2<@5.5)&(:105-150@OP=)" maskout rev_5.5.dat
	mask "(@NZ,NH1,NH2<@3.5)&(:105-150@OP=)" maskout rev_3.5.dat
      #neutralized phosphates
	mask "(:105@OP=<:5.5)&:1-104&( :LYS@NZ | :ARG@NH1,NH2 )" maskout maskout_P105.dat
	mask "(:106@OP=<:5.5)&:1-104&( :LYS@NZ | :ARG@NH1,NH2 )" maskout maskout_P106.dat
	mask "(:107@OP=<:5.5)&:1-104&( :LYS@NZ | :ARG@NH1,NH2 )" maskout maskout_P107.dat
	mask "(:108@OP=<:5.5)&:1-104&( :LYS@NZ | :ARG@NH1,NH2 )" maskout maskout_P108.dat
	mask "(:109@OP=<:5.5)&:1-104&( :LYS@NZ | :ARG@NH1,NH2 )" maskout maskout_P109.dat
	mask "(:110@OP=<:5.5)&:1-104&( :LYS@NZ | :ARG@NH1,NH2 )" maskout maskout_P110.dat
	mask "(:111@OP=<:5.5)&:1-104&( :LYS@NZ | :ARG@NH1,NH2 )" maskout maskout_P111.dat
	mask "(:112@OP=<:5.5)&:1-104&( :LYS@NZ | :ARG@NH1,NH2 )" maskout maskout_P112.dat
	mask "(:113@OP=<:5.5)&:1-104&( :LYS@NZ | :ARG@NH1,NH2 )" maskout maskout_P113.dat
	mask "(:114@OP=<:5.5)&:1-104&( :LYS@NZ | :ARG@NH1,NH2 )" maskout maskout_P114.dat
	mask "(:115@OP=<:5.5)&:1-104&( :LYS@NZ | :ARG@NH1,NH2 )" maskout maskout_P115.dat
	mask "(:116@OP=<:5.5)&:1-104&( :LYS@NZ | :ARG@NH1,NH2 )" maskout maskout_P116.dat
	mask "(:117@OP=<:5.5)&:1-104&( :LYS@NZ | :ARG@NH1,NH2 )" maskout maskout_P117.dat
	mask "(:118@OP=<:5.5)&:1-104&( :LYS@NZ | :ARG@NH1,NH2 )" maskout maskout_P118.dat
	mask "(:119@OP=<:5.5)&:1-104&( :LYS@NZ | :ARG@NH1,NH2 )" maskout maskout_P119.dat
	mask "(:120@OP=<:5.5)&:1-104&( :LYS@NZ | :ARG@NH1,NH2 )" maskout maskout_P120.dat
	mask "(:121@OP=<:5.5)&:1-104&( :LYS@NZ | :ARG@NH1,NH2 )" maskout maskout_P121.dat
	mask "(:122@OP=<:5.5)&:1-104&( :LYS@NZ | :ARG@NH1,NH2 )" maskout maskout_P122.dat
	mask "(:123@OP=<:5.5)&:1-104&( :LYS@NZ | :ARG@NH1,NH2 )" maskout maskout_P123.dat
	mask "(:124@OP=<:5.5)&:1-104&( :LYS@NZ | :ARG@NH1,NH2 )" maskout maskout_P124.dat
	mask "(:125@OP=<:5.5)&:1-104&( :LYS@NZ | :ARG@NH1,NH2 )" maskout maskout_P125.dat
	mask "(:126@OP=<:5.5)&:1-104&( :LYS@NZ | :ARG@NH1,NH2 )" maskout maskout_P126.dat
	mask "(:127@OP=<:5.5)&:1-104&( :LYS@NZ | :ARG@NH1,NH2 )" maskout maskout_P127.dat
	mask "(:128@OP=<:5.5)&:1-104&( :LYS@NZ | :ARG@NH1,NH2 )" maskout maskout_P128.dat
	mask "(:129@OP=<:5.5)&:1-104&( :LYS@NZ | :ARG@NH1,NH2 )" maskout maskout_P129.dat
	mask "(:130@OP=<:5.5)&:1-104&( :LYS@NZ | :ARG@NH1,NH2 )" maskout maskout_P130.dat
	mask "(:131@OP=<:5.5)&:1-104&( :LYS@NZ | :ARG@NH1,NH2 )" maskout maskout_P131.dat
	mask "(:132@OP=<:5.5)&:1-104&( :LYS@NZ | :ARG@NH1,NH2 )" maskout maskout_P132.dat
	mask "(:133@OP=<:5.5)&:1-104&( :LYS@NZ | :ARG@NH1,NH2 )" maskout maskout_P133.dat
	mask "(:134@OP=<:5.5)&:1-104&( :LYS@NZ | :ARG@NH1,NH2 )" maskout maskout_P134.dat
	mask "(:135@OP=<:5.5)&:1-104&( :LYS@NZ | :ARG@NH1,NH2 )" maskout maskout_P135.dat
	mask "(:136@OP=<:5.5)&:1-104&( :LYS@NZ | :ARG@NH1,NH2 )" maskout maskout_P136.dat
	mask "(:137@OP=<:5.5)&:1-104&( :LYS@NZ | :ARG@NH1,NH2 )" maskout maskout_P137.dat
	mask "(:138@OP=<:5.5)&:1-104&( :LYS@NZ | :ARG@NH1,NH2 )" maskout maskout_P138.dat
	mask "(:139@OP=<:5.5)&:1-104&( :LYS@NZ | :ARG@NH1,NH2 )" maskout maskout_P139.dat
	mask "(:140@OP=<:5.5)&:1-104&( :LYS@NZ | :ARG@NH1,NH2 )" maskout maskout_P140.dat
	mask "(:141@OP=<:5.5)&:1-104&( :LYS@NZ | :ARG@NH1,NH2 )" maskout maskout_P141.dat
	mask "(:142@OP=<:5.5)&:1-104&( :LYS@NZ | :ARG@NH1,NH2 )" maskout maskout_P142.dat
	mask "(:143@OP=<:5.5)&:1-104&( :LYS@NZ | :ARG@NH1,NH2 )" maskout maskout_P143.dat
	mask "(:144@OP=<:5.5)&:1-104&( :LYS@NZ | :ARG@NH1,NH2 )" maskout maskout_P144.dat
	mask "(:145@OP=<:5.5)&:1-104&( :LYS@NZ | :ARG@NH1,NH2 )" maskout maskout_P145.dat
	mask "(:146@OP=<:5.5)&:1-104&( :LYS@NZ | :ARG@NH1,NH2 )" maskout maskout_P146.dat
	mask "(:147@OP=<:5.5)&:1-104&( :LYS@NZ | :ARG@NH1,NH2 )" maskout maskout_P147.dat
	mask "(:148@OP=<:5.5)&:1-104&( :LYS@NZ | :ARG@NH1,NH2 )" maskout maskout_P148.dat
	mask "(:149@OP=<:5.5)&:1-104&( :LYS@NZ | :ARG@NH1,NH2 )" maskout maskout_P149.dat
	mask "(:150@OP=<:5.5)&:1-104&( :LYS@NZ | :ARG@NH1,NH2 )" maskout maskout_P150.dat
		#water counts per residue
	watershell :1 out watershell_1 lower 3.4 upper 5.0 noimage :WAT
	watershell :2 out watershell_2 lower 3.4 upper 5.0 noimage :WAT
	watershell :3 out watershell_3 lower 3.4 upper 5.0 noimage :WAT
	watershell :4 out watershell_4 lower 3.4 upper 5.0 noimage :WAT
	watershell :5 out watershell_5 lower 3.4 upper 5.0 noimage :WAT
	watershell :6 out watershell_6 lower 3.4 upper 5.0 noimage :WAT
	watershell :7 out watershell_7 lower 3.4 upper 5.0 noimage :WAT
	watershell :8 out watershell_8 lower 3.4 upper 5.0 noimage :WAT
	watershell :9 out watershell_9 lower 3.4 upper 5.0 noimage :WAT
	watershell :10 out watershell_10 lower 3.4 upper 5.0 noimage :WAT
	watershell :11 out watershell_11 lower 3.4 upper 5.0 noimage :WAT
	watershell :12 out watershell_12 lower 3.4 upper 5.0 noimage :WAT
	watershell :13 out watershell_13 lower 3.4 upper 5.0 noimage :WAT
	watershell :14 out watershell_14 lower 3.4 upper 5.0 noimage :WAT
	watershell :15 out watershell_15 lower 3.4 upper 5.0 noimage :WAT
	watershell :16 out watershell_16 lower 3.4 upper 5.0 noimage :WAT
	watershell :17 out watershell_17 lower 3.4 upper 5.0 noimage :WAT
	watershell :18 out watershell_18 lower 3.4 upper 5.0 noimage :WAT
	watershell :19 out watershell_19 lower 3.4 upper 5.0 noimage :WAT
	watershell :20 out watershell_20 lower 3.4 upper 5.0 noimage :WAT
	watershell :21 out watershell_21 lower 3.4 upper 5.0 noimage :WAT
	watershell :22 out watershell_22 lower 3.4 upper 5.0 noimage :WAT
	watershell :23 out watershell_23 lower 3.4 upper 5.0 noimage :WAT
	watershell :24 out watershell_24 lower 3.4 upper 5.0 noimage :WAT
	watershell :25 out watershell_25 lower 3.4 upper 5.0 noimage :WAT
	watershell :26 out watershell_26 lower 3.4 upper 5.0 noimage :WAT
	watershell :27 out watershell_27 lower 3.4 upper 5.0 noimage :WAT
	watershell :28 out watershell_28 lower 3.4 upper 5.0 noimage :WAT
	watershell :29 out watershell_29 lower 3.4 upper 5.0 noimage :WAT
	watershell :30 out watershell_30 lower 3.4 upper 5.0 noimage :WAT
	watershell :31 out watershell_31 lower 3.4 upper 5.0 noimage :WAT
	watershell :32 out watershell_32 lower 3.4 upper 5.0 noimage :WAT
	watershell :33 out watershell_33 lower 3.4 upper 5.0 noimage :WAT
	watershell :34 out watershell_34 lower 3.4 upper 5.0 noimage :WAT
	watershell :35 out watershell_35 lower 3.4 upper 5.0 noimage :WAT
	watershell :36 out watershell_36 lower 3.4 upper 5.0 noimage :WAT
	watershell :37 out watershell_37 lower 3.4 upper 5.0 noimage :WAT
	watershell :38 out watershell_38 lower 3.4 upper 5.0 noimage :WAT
	watershell :39 out watershell_39 lower 3.4 upper 5.0 noimage :WAT
	watershell :40 out watershell_40 lower 3.4 upper 5.0 noimage :WAT
	watershell :41 out watershell_41 lower 3.4 upper 5.0 noimage :WAT
	watershell :42 out watershell_42 lower 3.4 upper 5.0 noimage :WAT
	watershell :43 out watershell_43 lower 3.4 upper 5.0 noimage :WAT
	watershell :44 out watershell_44 lower 3.4 upper 5.0 noimage :WAT
	watershell :45 out watershell_45 lower 3.4 upper 5.0 noimage :WAT
	watershell :46 out watershell_46 lower 3.4 upper 5.0 noimage :WAT
	watershell :47 out watershell_47 lower 3.4 upper 5.0 noimage :WAT
	watershell :48 out watershell_48 lower 3.4 upper 5.0 noimage :WAT
	watershell :49 out watershell_49 lower 3.4 upper 5.0 noimage :WAT
	watershell :50 out watershell_50 lower 3.4 upper 5.0 noimage :WAT
	watershell :51 out watershell_51 lower 3.4 upper 5.0 noimage :WAT
	watershell :52 out watershell_52 lower 3.4 upper 5.0 noimage :WAT
	watershell :53 out watershell_53 lower 3.4 upper 5.0 noimage :WAT
	watershell :54 out watershell_54 lower 3.4 upper 5.0 noimage :WAT
	watershell :55 out watershell_55 lower 3.4 upper 5.0 noimage :WAT
	watershell :56 out watershell_56 lower 3.4 upper 5.0 noimage :WAT
	watershell :57 out watershell_57 lower 3.4 upper 5.0 noimage :WAT
	watershell :58 out watershell_58 lower 3.4 upper 5.0 noimage :WAT
	watershell :59 out watershell_59 lower 3.4 upper 5.0 noimage :WAT
	watershell :60 out watershell_60 lower 3.4 upper 5.0 noimage :WAT
	watershell :61 out watershell_61 lower 3.4 upper 5.0 noimage :WAT
	watershell :62 out watershell_62 lower 3.4 upper 5.0 noimage :WAT
	watershell :63 out watershell_63 lower 3.4 upper 5.0 noimage :WAT
	watershell :64 out watershell_64 lower 3.4 upper 5.0 noimage :WAT
	watershell :65 out watershell_65 lower 3.4 upper 5.0 noimage :WAT
	watershell :66 out watershell_66 lower 3.4 upper 5.0 noimage :WAT
	watershell :67 out watershell_67 lower 3.4 upper 5.0 noimage :WAT
	watershell :68 out watershell_68 lower 3.4 upper 5.0 noimage :WAT
	watershell :69 out watershell_69 lower 3.4 upper 5.0 noimage :WAT
	watershell :70 out watershell_70 lower 3.4 upper 5.0 noimage :WAT
	watershell :71 out watershell_71 lower 3.4 upper 5.0 noimage :WAT
	watershell :72 out watershell_72 lower 3.4 upper 5.0 noimage :WAT
	watershell :73 out watershell_73 lower 3.4 upper 5.0 noimage :WAT
	watershell :74 out watershell_74 lower 3.4 upper 5.0 noimage :WAT
	watershell :75 out watershell_75 lower 3.4 upper 5.0 noimage :WAT
	watershell :76 out watershell_76 lower 3.4 upper 5.0 noimage :WAT
	watershell :77 out watershell_77 lower 3.4 upper 5.0 noimage :WAT
	watershell :78 out watershell_78 lower 3.4 upper 5.0 noimage :WAT
	watershell :79 out watershell_79 lower 3.4 upper 5.0 noimage :WAT
	watershell :80 out watershell_80 lower 3.4 upper 5.0 noimage :WAT
	watershell :81 out watershell_81 lower 3.4 upper 5.0 noimage :WAT
	watershell :82 out watershell_82 lower 3.4 upper 5.0 noimage :WAT
	watershell :83 out watershell_83 lower 3.4 upper 5.0 noimage :WAT
	watershell :84 out watershell_84 lower 3.4 upper 5.0 noimage :WAT
	watershell :85 out watershell_85 lower 3.4 upper 5.0 noimage :WAT
	watershell :86 out watershell_86 lower 3.4 upper 5.0 noimage :WAT
	watershell :87 out watershell_87 lower 3.4 upper 5.0 noimage :WAT
	watershell :88 out watershell_88 lower 3.4 upper 5.0 noimage :WAT
	watershell :89 out watershell_89 lower 3.4 upper 5.0 noimage :WAT
	watershell :90 out watershell_90 lower 3.4 upper 5.0 noimage :WAT
	watershell :91 out watershell_91 lower 3.4 upper 5.0 noimage :WAT
	watershell :92 out watershell_92 lower 3.4 upper 5.0 noimage :WAT
	watershell :93 out watershell_93 lower 3.4 upper 5.0 noimage :WAT
	watershell :94 out watershell_94 lower 3.4 upper 5.0 noimage :WAT
	watershell :95 out watershell_95 lower 3.4 upper 5.0 noimage :WAT
	watershell :96 out watershell_96 lower 3.4 upper 5.0 noimage :WAT
	watershell :97 out watershell_97 lower 3.4 upper 5.0 noimage :WAT
	watershell :98 out watershell_98 lower 3.4 upper 5.0 noimage :WAT
	watershell :99 out watershell_99 lower 3.4 upper 5.0 noimage :WAT
	watershell :100 out watershell_100 lower 3.4 upper 5.0 noimage :WAT
	watershell :101 out watershell_101 lower 3.4 upper 5.0 noimage :WAT
	watershell :102 out watershell_102 lower 3.4 upper 5.0 noimage :WAT
	watershell :103 out watershell_103 lower 3.4 upper 5.0 noimage :WAT
	watershell :104 out watershell_104 lower 3.4 upper 5.0 noimage :WAT
		#rmsf for BA and SC
	atomicfluct out fluct.protein_SC.apf :1-104&!@C,CA,N,O,H= byres
	atomicfluct out fluct.protein_BA.apf :1-104@C,CA,N,O byres
		#distance for Q336, E343/R378, and DNA
	distance q2 :136@OP2 :4@NE2 out dist_4-136.dat noimage
	distance sb :11@OE1,OE2 :46@NH1,NH2 out dist_SB.dat noimage
	distance arg :137@OP1 :46@NH1,NH2 out dist_48-DNA.dat noimage
		#hydrogen bond analysis 
	hbond DNA out hbond.DNA.dat :105-150 angle 135 dist 3.0 avgout hbond_avg.DNA.out bridgeout hbond_brid.DNA.dat solventdonor :WAT solventacceptor :WAT@O nointramol
	hbond pro out hbond.protein.dat :1-104 angle 135 dist 3.0 avgout hbond_avg.protein.out bridgeout hbond_brid.protein.dat solventdonor :WAT solventacceptor :WAT@O 
	hbond com out hbond.complex.dat :1-150 angle 135 dist 3.0 avgout hbond_avg.complex.out bridgeout hbond_brid.complex.dat solventdonor :WAT solventacceptor :WAT@O nointramol
	hbond turn out hbond.turn.dat :46-51,105-150 angle 135 dist 3.0 avgout hbond_avg.turn.out bridgeout hbond_brid.turn.dat solventdonor :WAT solventacceptor :WAT@O nointramol
	hbond wing out hbond.wing.dat :72-76,105-150 angle 135 dist 3.0 avgout hbond_avg.wing.out bridgeout hbond_brid.wing.dat solventdonor :WAT solventacceptor :WAT@O nointramol
EOF

mpirun --bind-to core -np 8 $AMBERHOME/bin/cpptraj.MPI -i analysis.ptraj

wait

rm analysis.ptraj
