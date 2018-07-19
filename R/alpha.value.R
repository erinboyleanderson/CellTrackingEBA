#' Function for calculating alpha values
#'
#' This function calculates alpha values, which is the slope of logMSD v logTime. output gives both the slope and the intercept. Alpha (the slope). 2 represents perfectly ballistic migration while 1 represents random migration.
#' @param df must contain logMSD and Time columns
#'
#'@export


alpha.value<-function(df){
  a<-df%>%
    filter(logMSD!=-Inf)%>% # remove inf values
    mutate(logTime=log10(Time)) # find log value
  # formula set up as y~x
  fit<-lm(a$logMSD~a$logTime)
  return(fit$coefficients)
}
