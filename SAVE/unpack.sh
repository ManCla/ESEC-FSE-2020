#!/bin/bash

#############
# script to unpack the videos into frames
# - takes the videos from the subfolders of videos
# - extracts the frames of each video in a folder
#   in the frame directory with same structure as the
#   videos directory
#############

DIR_VIDEOS=videos
DIR_FRAMES=frames

# create frames directory if needed
mkdir -p ${DIR_FRAMES}

for dirname in `ls ${DIR_VIDEOS}`; do #iterate over 360P, 480P, 720P, 1080P, 2160P
	TARGETDIR="unpacked_${dirname}"
	mkdir -p ${DIR_FRAMES}/$TARGETDIR
	cd ${DIR_VIDEOS}/$dirname
	for filename in *.mp4; do
		base=${filename%.mp4}
		mkdir ../../${DIR_FRAMES}/${TARGETDIR}/${base}
		mplayer -vo jpeg:quality=100:outdir=../../${DIR_FRAMES}/${TARGETDIR}/${base} \
		$filename > /dev/null 2>&1
	done
	cd ../..
done

