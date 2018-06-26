#' logMSD
#'
#' Calucaltes logMSD of a timeseries over time
#' @param df dataframe
#' logMSD()
logMSD<-function(df){
  a<-displacement.XY(df)%>%
    mutate(logMSD=log(displacement^2/max(Track)))
  return(a)
}
