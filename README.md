# CellTrackingEBA

This is my cell tracking package, for tracking cells in the limb field of the LPM. 

Most of it is function for aligning and registering the embryos after imaging, although there are also some statistics and calculations.

Everything is assuming the input is a time series from the Manual Tracking plugin on FIJI. 

## IMPORT DATA

1. First need to manually combine the raw data from Manual Tracking (FIJI) into a dataframe for each genotype. I use the column headings Embryo, Time, Track, X, Y and so YOU MUST ALSO USE THEM because that is what the code calls them. I usually import with a read.csv from the files saved from tracking.
2. Also need a drift dataframe (same column headings) for each embryo, a somite dataframe (just frame 1) and a side dataframe. There are also explanations of what these dataframes need under the formulas that use them

## DATA REGISTRATION

Run the dataframe through these functions, in the order listed. This will generate embryos positioned in the correct orientation (Anterior to left, Medial top)

1. driftcorrect
2. rotate
3. rotate.somites
4. label.somites
5. MLquartile
6. tracks.in.range (confirmation)

## STATISTICS AND CALCULATIONS

I included the more useful or complicated ones that I have been using

* convergence (conververgence, convergenceML, scatter) 
* persistance (persistance.fun)
* speed (speedfun) 
* displacement (displacement.func, displacement.XY)
* tracklength.somite
* tracklength
* log.MSD
* alpha.value (for calculating ballistic migration)

## THINGS I DID NOT INCLUDE IN THIS PACKAGE

* code for generating graphs (mine are mostly ggplot2 based)
* initial import of data and cleanup (again too specific)
