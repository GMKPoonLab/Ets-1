#!/bin/bash

export AMBERHOME=/path/to/amber16
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$AMBERHOME/lib
source $AMBERHOME/amber16/amber.sh

cur_home=/path/to/curves+_v3.0nc

	#this works with a prestripped trajectory, ie water, ions, and anything not DNA has been removed

	#prompt for input
read -e -p "Input trajectory: " trj
read -e -p "Topology: " top
read -p "5-3 base pair range (1:10): " lead
read -p "3-5 base pair range (20:11): " lag
	#0 means it will perform pseudo-time series analysis 
	#1 computes just a net average 
read -p "Trajectory average [1] or multi frame [0]: " fork

	#pre cleanup
rm curves.in *.lis *.cda *.lis* dna_*.pdb GP_calc Cur_pull BP_P_stor BP_Ax_stor BP_St_calc tot_bend

wait

if [ "${fork}" -eq "1" ] ; then

cat >curves.in<<EOF 
${cur_home}/Cur+ <<!
&inp 
 file=${trj},
 lis=dna,
 ftop=${top},
 lib=${cur_home}/standard,
 line=.f.,
&end
2 1 -1 0 0
${lead}
${lag}
!
EOF

	wait

	chmod 755 curves.in

	./curves.in
		#single mode

	wait

	rm curves.in
	rm trj_c*

		#curves+ should output sequence info to line 26
	dseq=`sed '26q;d' dna.lis | sed 's/.*: //'`

cat >curves.in<<EOF 
${cur_home}/canal <<!
&inp	
 lis=trj_c,seq=*,
 iwin=1, clim=0,
 lev1=0,
 lev2=0,
 histo=.f.,
 series=.f.,	
&end	
dna.cda ${dseq}
!
EOF

	chmod 755 curves.in
	./curves.in
		#traj mode

		#spits out 4 lines per frame in the cda

	sed -n '24p;25p;27,75p' trj_c.lis > C+_out

	#split into multi pdb by cpptraj
elif [ "${fork}" -eq "0" ]; then

	cf=`cpptraj -p ${top} -y ${trj} -tl | awk '{print $2}'`
	sf=1

		#make filler files
	echo -e "" > tot_bend
	echo -e "" > BP_Ax_Xdisp
	echo -e "" > BP_Ax_Ydisp
	echo -e "" > BP_Ax_inclin
	echo -e "" > BP_Ax_tip
	echo -e "" > BP_Ax_bend
	echo -e "" > BP_shear
	echo -e "" > BP_stretch
	echo -e "" > BP_stagger
	echo -e "" > BP_buckle
	echo -e "" > BP_propel
	echo -e "" > BP_open

		#start a counter based on frames
	while [ ${sf} -le ${cf} ]; do

cat >curves.in<<EOF 
${cur_home}/Cur+ <<!
&inp 
 file=${trj},
 lis=dna,
 ftop=${top},
 lib=${cur_home}/standard,
 line=.f.,
 itst=${sf},itnd=${sf}
&end
2 1 -1 0 0
${lead}
${lag}
!
EOF

	wait

	chmod 755 curves.in
		#run curves
	./curves.in

		wait

		echo "Moving to parsing"

		#BP axis
		sed -n '/(A)/,/Average/{/Average/!p}' dna.lis | awk 'NR>2 {print $3,$5,$6,$7,$8,$9}' | sed -e 's/---/0.0/g' | column -t > BP_Ax1

		#BP line counter
		BP_lc=`wc -l BP_Ax1 | awk '{print $1}'`

		awk -v a=${BP_lc} '{ printf "%s\t", $2 } NR%a==0{ print "" }' < BP_Ax1 >> BP_Ax_Xdisp
		awk -v a=${BP_lc} '{ printf "%s\t", $3 } NR%a==0{ print "" }' < BP_Ax1 >> BP_Ax_Ydisp
		awk -v a=${BP_lc} '{ printf "%s\t", $4 } NR%a==0{ print "" }' < BP_Ax1 >> BP_Ax_inclin
		awk -v a=${BP_lc} '{ printf "%s\t", $5 } NR%a==0{ print "" }' < BP_Ax1 >> BP_Ax_tip
		awk -v a=${BP_lc} '{ printf "%s\t", $6 } NR%a==0{ print "" }' < BP_Ax1 >> BP_Ax_bend

			wait

		#total bend- easier to deal with on its own
		grep 'Total bend' dna.lis | sed 's/^.*= //' | awk '{print $1}' >> tot_bend

		wait

		#BP parameters
		sed -n '/(B)/,/Average/{/Average/!p}' dna.lis | awk 'NR>4 {print $3,$5,$6,$7,$8,$9,$10}' | column -t > BP_P1

		awk -v a=${BP_lc} '{ printf "%s\t", $2 } NR%a==0{ print "" }' < BP_P1 >> BP_shear
		awk -v a=${BP_lc} '{ printf "%s\t", $3 } NR%a==0{ print "" }' < BP_P1 >> BP_stretch
		awk -v a=${BP_lc} '{ printf "%s\t", $4 } NR%a==0{ print "" }' < BP_P1 >> BP_stagger
		awk -v a=${BP_lc} '{ printf "%s\t", $5 } NR%a==0{ print "" }' < BP_P1 >> BP_buckle
		awk -v a=${BP_lc} '{ printf "%s\t", $6 } NR%a==0{ print "" }' < BP_P1 >> BP_propel
		awk -v a=${BP_lc} '{ printf "%s\t", $7 } NR%a==0{ print "" }' < BP_P1 >> BP_open

			wait

			#reset count for BP number
			unset BP_lc

			wait

		#BP step 
		sed -n '/(C)/,/Average/{/Average/!p}' dna.lis | awk 'NR>2 {print $3,$5,$6,$7,$8,$9,$10,$11,$12}' | column -t > BP_St1

		BP_lc=`wc -l BP_St1 | awk '{print $1}'`

		awk -v a=${BP_lc} '{ printf "%s\t", $2 } NR%a==0{ print "" }' < BP_St1 >> BP_St_shift
		awk -v a=${BP_lc} '{ printf "%s\t", $3 } NR%a==0{ print "" }' < BP_St1 >> BP_St_slide
		awk -v a=${BP_lc} '{ printf "%s\t", $4 } NR%a==0{ print "" }' < BP_St1 >> BP_St_rise
		awk -v a=${BP_lc} '{ printf "%s\t", $5 } NR%a==0{ print "" }' < BP_St1 >> BP_St_tilt
		awk -v a=${BP_lc} '{ printf "%s\t", $6 } NR%a==0{ print "" }' < BP_St1 >> BP_St_roll
		awk -v a=${BP_lc} '{ printf "%s\t", $7 } NR%a==0{ print "" }' < BP_St1 >> BP_St_twist
		awk -v a=${BP_lc} '{ printf "%s\t", $8 } NR%a==0{ print "" }' < BP_St1 >> BP_St_Hris
		awk -v a=${BP_lc} '{ printf "%s\t", $9 } NR%a==0{ print "" }' < BP_St1 >> BP_St_Htwis

			wait

			unset BP_lc

			wait

		#backbone parm? this one's weird so skipping for now
		#sed -n '/(D)/,/(E)/{/(E)/!p}' dna.lis > C++_temp

		#groove parms- very messy
		#fetch part out of whole, remove extra bits+print every 2 lines, print relavent columns, and remove blank lines
		sed -n '/(E)/,/(F)/{/(F)/!p}' dna.lis | awk 'NR ==6 || NR % 2 == 0' | awk '{print $2,$3,$4,$5,$6,$7}' | awk  '$1!=""' > GP_temp

		awk '{print $2}' GP_temp | sed -e 's/^$/0/' > 1
		awk '{print $3}' GP_temp | sed -e 's/^$/0/' > 3
		awk '{print $4}' GP_temp | sed -e 's/^$/0/' > 4
		awk '{print $5}' GP_temp | sed -e 's/^$/0/' > 5
		awk '{print $6}' GP_temp | sed -e 's/^$/0/' > 6

		paste 1 3 4 5 6 > GP_new

		BP_lc=`wc -l GP_new | awk '{print $1}'`

		awk -v a=${BP_lc} '{ printf "%s\t", $2 } NR%a==0{ print "" }' < GP_new >> BP_MinWid
		awk -v a=${BP_lc} '{ printf "%s\t", $3 } NR%a==0{ print "" }' < GP_new >> BP_MinDep
		awk -v a=${BP_lc} '{ printf "%s\t", $4 } NR%a==0{ print "" }' < GP_new >> BP_MajWid
		awk -v a=${BP_lc} '{ printf "%s\t", $5 } NR%a==0{ print "" }' < GP_new >> BP_MajDep

			wait

			rm GP_calc GP_temp GP_new 1 3 4 5 6

			wait

				#lots of cleanup
				rm curves.in *.lis *.cda *.lis* dna_*.pdb 

				echo "Frame ${sf} done"
				let sf=sf+1

	done

fi
