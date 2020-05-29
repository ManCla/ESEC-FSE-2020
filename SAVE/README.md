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
  
In the directory are present also the bash scpripts that allow automated processing of the videos (*unpack.sh* and *run.sh*) and generation of the paper images.

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
     > sudo apt-get install texlive-latex-extra \

## Instructions for reproducing the results


## Instructions for reuse

## The dataset
