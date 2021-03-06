% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/logMSD.R
\name{logMSD}
\alias{logMSD}
\title{logMSD}
\usage{
logMSD(df)
}
\arguments{
\item{df}{dataframe. Must have X, Y and Time columns in order to work}
}
\description{
Calucaltes logMSD of a timeseries over time. Combines all embryos in the dataframe into one dataseries. Gives both MSD and log10MSD as results. Note that log10MSD at time 1 may be -Inf, if displacement at Time 1=0
}
