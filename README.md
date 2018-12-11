# CellTrackingEBA

This is my cell tracking package, for tracking cells in the limb field of the LPM. 

Most of it is function for aligning and registering the embryos after imaging, although there are also some statistics and calculations.

Everything is assuming the input is a time series from the Manual Tracking plugin on FIJI. 

## IMPORT DATA

I manually import the following data as dataframes, so that all data for all embryos in a given genotype is in one dataframe for each of the following.

1. First need to manually combine the raw data from Manual Tracking (FIJI) into a dataframe for each genotype. I use the column headings Embryo, Time, Track, X, Y and so YOU MUST ALSO USE THEM because that is what the code calls them. I usually import with a read.csv from the files saved from tracking.
2. You also need a drift dataframe (same column headings as above) for each embryo
3. A somite dataframe of the somite positions at frame 1. I measure at the boundaries between each somite on the lateral edge of the somite. Headers should be Embryo, X, Y, boundary. For boundary, I set the name of the two somites, so the boundary between somites 1 and 2 is "1-2", and so on. You must have minimally boundaries 0-1 to 5-6, but you can add additional dataframes.
4. A side dataframe. This indicates whether you tracked the left or the right LPM. Headers are Embryo, Side, multiplier, in that case. Multiplier is either 1 or -1, with 1 for the left side and -1 for the right side. Side values are either Right or Left.


## DATA REGISTRATION

Run the dataframe through these functions, in the order listed. This will generate embryos positioned in the correct orientation (Anterior to left, Medial top). These work on one genotype at a time.

1. driftcorrect
2. rotate
3. rotate.somites
4. label.somites
5. MLquartile
6. tracks.in.range (confirmation)

After this stage, I generally combine datasets so that all data is in one giant dataframe with an additional column for genotype. This is necessary for most of the following functions.

## STATISTICS AND CALCULATIONS

I included the more useful or complicated ones that I have been using

* convergence (conververgence, convergenceML, scatter, scatter.somite) 
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
