#!/bin/bash

InputBam=Noss.R1.sam

#echo "Please enter the name of sam input file: "
#read InputBam
if [ -f $InputBam ];
then
	echo "File $InputBam exists."
else
	echo "File $InputBam does not exist."
	exit
fi
#echo $InputBam
# set Internal_Field_Separator(IFS) to \. to remove .sam from end of filename
IFS=\.
arr=($InputBam)
input=${arr[0]}
#echo $input
# restore the default IFS
IFS=$OIFS
#echo "Please enter the name of TE annotation file: "
#read annotation;
#if [ -f $annotation ];
#then
#   echo "File $annotation exists."
#else
#   echo "File $annotation does not exist."
#exit

#fi

referenceGenome=scaffold.fas

#echo "Please enter the name of reference genome file: "
#read referenceGenome;
#if [ -f $referenceGenome ];
#then
#	echo "File $referenceGenome exists."
#else
#	echo "File $referenceGenome does not exist."
#	exit
#fi
#echo $annotation
#echo $referenceGenome

#samtools view -h $InputBam >$input'.sam'

python ../scripts/toprintend1.py $input'.sam' $input'_end.sam'

python ../scripts/Selectnonrepeated1.py $input'_end.sam' $input'_hits_nonrepeated.sam'

#python Selectmultiplemap1.py $input'_hits_nonrepeated.sam' $input'_multiplemapped_reads.sam' $input'_uniquelymapped_reads.sam'

#python new_cases1.py $input'_multiplemapped_reads.sam' $annotation >$input'_multiplecorrected.sam'

#cat $input'_multiplecorrected.sam' $input'_uniquelymapped_reads.sam' >$input'_merged.sam'

python ../scripts/removeEnd1.py $input'_hits_nonrepeated.sam' >$input'_output_final.sam'

samtools view -bT $referenceGenome $input'_output_final.sam' >$input'outfile.bam'

echo "All multiple mapping errors corrected for $Input."