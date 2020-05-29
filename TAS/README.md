# TAS case study

## Directory structure and content
The directory is divided in two subdirectories:
  * *code*: the code directory contains the matlab funcitons and scripts that implement the simulator.
  * *fig*: the fig directory contains the .tex file generating the paper figure and a makefile scripting the generation process.

## System requirements
The simulation is run in Matlab, and will require the statistics and machine learning toolbox. No specific version of Matlab is required.

## Instructions for reproducing the results from the paper
Two steps are required to reproduce the results presented in the paper: one runnning the simulation of the TAS system and a second one generating the figure found in the paper. 

 * In matlab run the script MAIN_tests.m in the /TAS/code directory. The script will sequentially: **(i)** load testing parameters, **(ii)** perform perform the tests (printing out the progress every 100 tests), **(iii)** generate the file maxima_growth_plot.csv in the /TAS/fig directory, and **(iv)** display two plots sumarizing the results.
 * To generate figure 3 from the paper you can now run the makefile in the directory /TAS/fig (latex and tikz are required). This requires the file maxima_growth_plot.csv so the matlab script has to be run before this step.

## Instructions for reuse
In the file MAIN_tests.m test number and the simulation parameters can be tweaked. 

  * At line 13 and 17 the number of tests can be changed. In the paper we used only one testset but the script allows to run several. The idea is that by comparing different randomly generated testsets we can evaluate the stability of the testing strategy.  Meaning that a testing strategy to be considered stable should provide similar results for different testsets. A number of tests different than one will also change the displayed plots summarizing the results.

  * At lines 20, 21, and 22 can be changed the number of service providers (for each of the services).

  * At lines 44, and 45 the probability of a request being of different kinds can be changed. In the paper simulations this is randomized to obtain results independent form the specific types of requests received (further explanation can be found in the paper).
