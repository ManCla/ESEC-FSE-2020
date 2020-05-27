#!/bin/bash

# ----------------------------------------------------------------- #
# This script executes the compression case study: it takes all the #
# mp4 videos placed in the folder "mp4" and process them. The       #
# processing is done in two steps: prepare, and encode.             #
# The prepare step creates the folder structure needed to execute   #
# the rest and unpacks the video into frames that are stored in the #
# corresponding folder. The encode step executes the encoder        #
# alongside with the control strategy that sets the actuator values #
# to obtain the goals.                                              #
#                                                                   #
# For each of the frames, the two procedures use as actuators three #
# parameters of the convert system call:                            #
#   - quality (from 1 to 100)                                       #
#   - noise (from 0 to 5)                                           #
#   - sharpen (from 0 to 5)                                         #
#                                                                   #
# There are three adaptation strategies already designed:           #
#   - random: just select random values for the actuators           #
#   - bangbang: implements a bangbang controller                    #
#   - mpc: implements a model predictive controller                 #
#                                                                   #
# The controllers tries to achieve two objectives:                  #
#   - a setpoint on the similarity with the original frame (ssim)   #
#   - a setpoint on the frame size after the conversion             #
# ----------------------------------------------------------------- #

DIR_FRAMES=frames
DIR_FRAMES_ORIG=orig
DIR_FRAMES_PROC=proc
DIR_RESULTS=results
PROGRAM=./code/encoder.py

function ref { # Random Element From
  declare -a array=("$@")
  r=$((RANDOM % ${#array[@]}))
  printf "%s\n" "${array[$r]}"
}

print_usage ()
{
  echo "<usage> call this script with parameters for the action:"
  echo "  ./run.sh input_folder control setpoint_quality"
  exit
}

encode ()
{
	V=$1; INPUTFOLDER=$2; METHOD=$3; QUALITY=$4; FRAMESIZE=$5;
	ORIG=${DIR_FRAMES}/${INPUTFOLDER}/${V}/${DIR_FRAMES_ORIG};
	BASIC_PROC=${DIR_FRAMES}/${INPUTFOLDER}/${V}/${DIR_FRAMES_PROC};
	BASIC_RESULTS=${DIR_RESULTS}/${INPUTFOLDER}/${V};
	
	if [[ -z "${QUALITY// }" ]]; then QUALITY=0.9; fi
	if [[ -z "${FRAMESIZE// }" ]]; then FRAMESIZE=8000; fi
	
	SUFFIX="${METHOD}-Q${QUALITY}-F${FRAMESIZE}"
	PROC="${BASIC_PROC}/${SUFFIX}"
	RESULTS="${BASIC_RESULTS}/${SUFFIX}"
	mkdir -p ${RESULTS}
	mkdir -p ${PROC}
	rm -rf ${RESULTS}/*
	rm -rf ${PROC}/*
	
	echo "  [encode] encoding of $V ($QUALITY, $FRAMESIZE)"
	python $PROGRAM $METHOD \
		$ORIG $PROC $RESULTS \
		$QUALITY $FRAMESIZE
	echo "  [encode] encoding of $V terminated"
	
	echo "  [encode] creating figure"
	cp ./code/latex/figure.tex $RESULTS/.
	cd $RESULTS
	pdflatex figure.tex &>/dev/null
	pdflatex figure.tex &>/dev/null
	rm -rf figure.tex figure.aux figure.log
	cd ../../../..
	echo "  [encode] creating figure terminated"
}


# ----------------------------------------------------------------- #

# usage printing
if [[ "$#" -eq 0 ]]; then
	print_usage;
	exit;
fi

#####################
# normal usage mode #
#####################

# input handling
INPUTFOLDER=$1 # the subfolder of the directory /${DIR_FRAMES} that you want to
               # process: it should contain one folder per video each containing
               # a folder DIR_FRAMES_ORIG with the unprocessed frames. 
METHOD=$2      # the adaptation strategy
QUALITY=$3     # ssim setpoint

# create results directory if needed
mkdir -p ${DIR_RESULTS}

VIDEOS=`ls frames/$INPUTFOLDER` # get list of videos to be processed
for VIDEO in $VIDEOS; do # iterate over the videos
	echo "Processing $VIDEO"
	# create directory for output logging
	BASIC_RESULTS=${DIR_RESULTS}/${INPUTFOLDER}/${VIDEO}; mkdir -p ${BASIC_RESULTS}
	# create direcotry for processed frames
	PROC=${DIR_FRAMES}/${INPUTFOLDER}/${VIDEO}/${DIR_FRAMES_PROC}; mkdir -p ${PROC}

	SIZES=`ls -l ${DIR_FRAMES}/${INPUTFOLDER}/${VIDEO}/${DIR_FRAMES_ORIG} | awk '{print $5}'` 
	FRAMESIZE_BASE=`ref $SIZES`
	if test -z "$FRAMESIZE_BASE"
	then
		FRAMESIZE_BASE=100000
	fi
	FRAMESIZE=`echo "$FRAMESIZE_BASE*0.75 /1" | bc`
	echo "Setpoints $QUALITY for quality and $FRAMESIZE for framesize"
	# encode the video
	encode $VIDEO $INPUTFOLDER $METHOD $QUALITY $FRAMESIZE

done

mail -s "Finished experiment for folder $INPUTFOLDER" maggio.martina@gmail.com <<< 'I am done, collect my results'
mail -s "Finished experiment for folder $INPUTFOLDER" claudio.mandrioli@control.lth.se <<< 'I am done, collect my results'

# cleanup
rm -f ./code/*/*.pyc

