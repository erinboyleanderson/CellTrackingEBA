#' Function for determining scatter by somite
#'
#' This function calculates the scatter value for each individual somite, using the scatterfun function. It calculates both AP scatter and ML scatter, and returns scatter per Embryo at each time point as well as mean scatter across all embryos of a given genotype.
#'
#' @param df time series tracking dataframe
#' @param somite.start starting somite that you want to determine value for, default value is 1
#' @param somite.final final somite you want to determine value for, default value is 5
#' @export

scatter.somite<-function(df, somite.start=1, somite.final=5){
  b<-data.frame()
  for(s in somite.start:somite.final){
    a<-filter(df, Somite==s)%>%
      scatterfun%>%
      mutate(Somite=s)
    b<-rbind.data.frame(b,a)
  }
  return(b)
}

