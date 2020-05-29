# TAS case study



## Directory structure and content

## System requirements

The simulation is run in Matlab, and will require the statistics and machine learning toolbox. No specific version of Matlab is required.

## Instructions for reproducing the results

Two steps are required to reproduce the results presented in the paper: one runnning the simulation of the TAS system and a second one generating the figure found in the paper. 

 * In matlab run the script MAIN_tests.m in the /TAS/code directory. The script will sequentially: (i) load testing parameters, (ii) perform 500 tests (prints out the progress every 100 tests), (iii) generate the file maxima_growth_plot.csv in the /TAS/fig directory, and (iv) display two plots sumarizing the results.
 * To generate figure 3 from the paper you can now run the makefile in the directory /TAS/fig (latex and tikz are required). This requires the file maxima_growth_plot.csv so the matlab script has to be run before this step.

## Instructions for reuse
