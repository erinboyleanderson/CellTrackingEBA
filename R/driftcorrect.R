#' Function for drift correction
#'
#' This function will drift correct the raw dataframe of X and Y coordinates collected from cell tracking. Important: both drift and raw dataframe must contain the following columns with the exact same column names: Embryo, Time, X, Y
#' @param driftDF Your dataframe for drift correction (i.e midline nuclei)
#' @param rawDF Raw dataframe
#' @param bros Number of bros in your dataframe
#' @export




driftcorrect<-function(driftDF,rawDF,bros){
  if(length(rawDF)==6) stop ("Not using Raw data, using the already processed data--confirm input is correct")

  #calculate mean value of drift at each Embryo and Timepoint
  drift.mean<-driftDF%>%
    group_by(Embryo,Time)%>%
    dplyr::mutate(mean(X),mean(Y))%>%
    dplyr::rename(meanX='mean(X)',meanY="mean(Y)")%>%
    select(Embryo,Time,meanX,meanY)%>%
    unique

  a<-left_join(rawDF,drift.mean,by=c("Embryo","Time")) #combine into one big df
  b<-filter(drift.mean,Time==1) #select time 1 in order to correct back to starting position

  Td<-data.frame()
  for(n in 1:bros){
    time1<-filter(b, Embryo==n)
    bigdf<-filter(a, Embryo==n)
    e<-bigdf%>%mutate(Xd=X-meanX+time1$meanX, #subtract drift at each time point then add back in time at t=1
                      Yd=Y-meanY+time1$meanY)
    Td<-rbind(Td,e)
    rm(time1, bigdf,e)
  }
  return(Td)

}
