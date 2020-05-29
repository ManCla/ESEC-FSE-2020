# SAVE case study 
This direcotry contains the SAVE artifact with the data used in the paper and the scripts to generate the paper results. Since processing the whole dataset can take long time (up to one week, depending on the machine that is used) also the final results showed in the paper are included for convenience.

This directory is a copy of the original artifact that has been modified for easing test automation and result logging.

## Directory structure and content
The directory is organized as follows:
  * The *code* directory contains the files of the adaptive video encoder.
  * The *fig* directory contains the files for generating the figure from the paper.
  * The *final_results* directory contains the data used for generating the figures in the paper (in case you don't want to wait the software to run on the whole dataset).
  * The *size_references* directory contains size references for the adaptation algorithm for each of the videos (as explained in the paper, the need for video-specific size reference arises from the significant differences in the frame size).
  * The *videos* directory contains a sbuset of the database used in the paper (instructions on how to retrieve and include the complete databse can be found below).
  
In the directory are present also the bash scpripts that allow automated processing of the videos (*unpack.sh* and *run.sh*) and generation of the paper images (**add script here**).

## System requirements
The system requirements are the same as the ones for the SAVE artifact.

### PREREQUISITES
In a normal ubuntu distribution (LTS), you need to install the packages:
python-imaging, python-numpy, python-scipy, python-matplotlib, python-cvxopt, mplayer, texlive-base, texlive-latex-extra, texlive-pictures.

### STEP-BY-STEP PREREQUISITES INSTALLATION
 > sudo apt-get install mplayer \
 > sudo apt-get install imagemagick \
 > sudo apt-get install python-imaging python-numpy python-scipy \
 > sudo apt-get install python-matplotlib python-cvxopt \
 > sudo apt-get install texlive-base texlive-pictures \
 > sudo apt-get install texlive-latex-extra 

## The dataset
The datased used in the paper is the *User Generated Content* dataset from youtube[1]: specifically we focused on the sport related videos[2], as explained in the paper, those videos are supposed to be very dynamic and will adequately trigger the adaptation of the encoder. The videos are organized in 5 subdirecotries (360P, 480P, 720P, 1080P, 2160P) each containing 31-33 videos. The dataset size is about 5.5Gb for this reason we include in the repository only couple of videos for subfolder. To process the complete dataset you can download it from this link **add link here** and substitute the videos folder.

## Instructions for reproducing the results
The paper results are reprodiced in three steps: (i) unpacking the videos, (ii) encoding the videos, and (iii) generating the figure. The scripts proces the videos in the 

  * The unpacking step is executed by running the shell script *unpack.sh*, in a terminal window execute:
    > ./unpack.sh 
    
    The script first creates the firectory *frames*. Then splits the videos in the individual frames into the directory just created. The script mantains the folders structure but changes the subfolder names (unpacked_360P, unpacked_480P, unpacked_720P, unpacked_1080P, unpacked_2160P).
    
  * The actual encoding of the videos is performed with the *run.sh* shell script. This script has to be called with two arguments: the target folder (one among: unpacked_360P, unpacked_480P, unpacked_720P, unpacked_1080P, unpacked_2160P) and the adaptation strategy (one among: random, integral, mpc, greedy). The complete dataset is prcessed by executing all the possible cxombinations.
    > ./run.sh unpacked_360P random \
    > ./run.sh unpacked_360P integral \
    > ... \
    > ./run.sh unpacked_480P random \
    > ./run.sh unpacked_480P integral \
    > ... 
Each execution of this script will create the directory *results* (if it doesn't exist yet) and in this directory log the data and results about the encoding. The encoded frames are instead stored in the *frames* folder. In the results directory the summary subdirectory contains the data for the figures and the other subdirectories contain the logging frame by frame (in caso other performance metrics want to be calculated withouth having to re-run the encoding).

  * The 

## Instructions for reuse



[1] https://media.withyoutube.com/ \
[2] https://console.cloud.google.com/storage/browser/ugc-dataset/original_videos/Sports/?pli=1 \
