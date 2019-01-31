#!/bin/bash

#note- this assumes the input is divisible by 5

  #prompt user for input file
  #input should be single column only
read -e -p "Input file: " input

rm R_block.R

  #make R script that reads in input as a matrix and block average over 5 blocks
cat >R_chisq.R<<EOF
	#read in input as table
a <- read.table("${input}")

	#change table to matrix for easier parsing
b <- as.matrix(a)

	#split up into matrix with 5 columns to represent blocks
c <- matrix(b, nrow=(nrow(a)/5))

	#calculate column means of matrix
d <- colMeans(c)

	#print mean of column means, and standard deviations
print(paste0("Block average: ", mean(d)))
print(paste0("Block SD: ", sd(d)))
EOF

	Rscript R_block.R
  
  wait
  
  rm R_block.R
