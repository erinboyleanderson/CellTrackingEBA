% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tracks.in.range.R
\name{tracks.in.range}
\alias{tracks.in.range}
\title{Function for determining the number of tracks in range}
\usage{
tracks.in.range(dataframe)
}
\arguments{
\item{dataframe}{Cellt racking dataframe, minimally must have one column named Embryo (to specify the embryo number) and one column named Track (to differentiate between different tracks)}
}
\description{
This function gives the number of tracks in any tracking dataframe. (It's especially helpful because when selecting a subset of tracks within a certain range, sometimes you get tracks in the middle filtered out because the tracks aren't always exactly in numerical order, depending on how you track them)
}
