# UCL-MSc-Code-Repository

This repository contains the relevant codes from Matthew Hurst's project for the MSc in Mathematical Modelling at UCL, submitted in September 2018.

The project was supervised by Professors Erik Burman and Edward Johnson from the UCL Department of Mathematics.

The contents of this repository are organized in a somewhat strange manner in order to preserve the referencing developed in the initial working. This repository was derived from the original working repository to remove extraneous code.

The directory "Figures" contains figures referenced in the report that were generated by the author.

The directory "FinalCode" contains the code and results from the implementation of the stationary model. This is limited to an exploration of the effect of several different background velocities. Within this directory, only one study ("01_") is included. The contents of this study directory will be described in detail later.

The directory "MatlabCode" contains the MATLAB code used for post-processing and generating figures. Within this directory, there is a chain of two other directories required to preserve the referencing used in the MATLAB code. The function "analyzeRun" contains the bulk of the post-processing code and is called by the scripts that analyzed each study. These scripts are labelled based on the name of the study and automatically analyze all of the results of that study.

The "References" directory contains many of the references used in this project as pdfs.

The LaTeX code used for the report is included in the root directory, including the preamble, the bibliography file, and the main tex file.

The "ServerCode" directory contains the majority of the code and results from this project. Both this directory and the "FinalCode" directory are organized as follows:

Each sub-directory is a separate study, named based on what the study is exploring. Take the "09" study, speed vs. alpha as an example. Within this directory are several scripts named with some variation of "main.edp." These are the primary FreeFem++ scripts. There is also a shell script "runfreefem.sh" and a "Results" directory. The shell script is used to run the main scripts, by simply running "runfreefem.sh" with the argument being the ".edp" script to be run. The shell script creates a sub-directory in "Results" with a time-stamp, to ensure that no results are being overwritten. The, it runs the argument FreeFem++ file and saves all of the results in the corresponding sub-directory, along with the "main" script used to generate those results. The directories have been renamed for clarity, as the time-stamping is only necessary to avoid data being overwritten.

In order to run the simulations, the user must have FreeFem++ downloaded and installed. FreeFem++ saves the mesh and the resultant solution variables along with plots of these solution variables in the domain. The other files in this directory have been generated by the MATLAB post-processing. For detailed information about what was run, see the ".edp" script within this directory. For convenience, the parameters of the problem, both dimensional and non-dimensional are written to a file called "problem_parameters.sol," which allows for the quick determination of the parameters of the study.

Each study (e.g. "alpha0_02") finds the background velocity resulting in zero net force on the wedge. Together, all of the studies in the "09_speed_vs_alpha" directory form a larger study characterizing this background velocity as a function of the slope of the wedge. The figures "speed_vs_alpha_dim.eps" and "speed_vs_alpha_nondim.eps" contain the post-processed results that include all of the cases (e.g. "alpha0_02," "alpha0_03," etc.).

All of the main study directories (e.g. "speed_vs_strat," "speed_vs_sc," have the same directory structure.

Again, to determine what code was run to produce which results, look at the deepest layer to find the ".edp" script alongside the results.

The "13" directory is simply the "clean" version of the code used in the appendix of the report.

Note that many of the codes included here will take several hours if run on a laptop machine. For the project, they were run on Amazon Web Services in order to distribute the load over many cores, hence the naming "ServerCode."

For any questions, please email matthew.ryan.hurst@gmail.com.