#' logMSD
#'
#' Calucaltes logMSD of a timeseries over time. Combines all embryos in the dataframe into one dataseries. Gives both MSD and log10MSD as results. Note that log10MSD at time 1 may be -Inf, if displacement at Time 1=0
#' @param df dataframe. Must have X, Y and Time columns in order to work
#' @export

logMSD<-function(df){
  b<-displacement.XY(df)%>%
    mutate(sqdisp=displacement^2)%>%
    group_by(Time)%>%
    summarise(MSD=mean(sqdisp))%>% # this gives us MSD
    mutate(logMSD=log10(MSD))
  return(b)
}
