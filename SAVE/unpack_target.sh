#!/bin/bash

#############
# script to unpacks videos into frames (for a target subfolder)
# - takes the videos from the subfolder of videos 
#   that is given as argument
# - extracts the frames of each video in a folder
#   in the frame directory with same structure as the
#   videos directory
#############

DIR_VIDEOS=videos
DIR_FRAMES=frames
DIR_FRAMES_ORIG=orig

print_usage ()
{
  echo "<usage> call this script with parameters:"
  echo "  ./unpack_target.sh input_folder "
  echo "           <input_folder : the subfolder of /videos to unpack>"
  exit
}

# ------------------------------------------------------------------------- #

# usage printing
if [[ "$#" -eq 0 ]]; then
	print_usage;
	exit;
fi

# create frames directory if needed
mkdir -p ${DIR_FRAMES}

# input handling
DIRNAME=$1

TARGETDIR="unpacked_${DIRNAME}"
mkdir -p ${DIR_FRAMES}/$TARGETDIR
cd ${DIR_VIDEOS}/$DIRNAME
for filename in *.mp4; do #iterate over videos in subfolder
    base=${filename%.mp4}
    echo "I am unpacking the $base video"
	mkdir ../../${DIR_FRAMES}/${TARGETDIR}/${base}
    mkdir ../../${DIR_FRAMES}/${TARGETDIR}/${base}/${DIR_FRAMES_ORIG}
	mplayer -vo \
      jpeg:quality=100:outdir=../../${DIR_FRAMES}/${TARGETDIR}/${base}/${DIR_FRAMES_ORIG} \
		  $filename > /dev/null 2>&1
done

cd ../..
