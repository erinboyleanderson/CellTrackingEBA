#' Function for determining convergence of the limb field
#'
#' This function gives a value to detect convergence over a given time series. It takes the average AP position of cells next to one somite and compares the distance to the average AP positiion of cells next to anouther somite group. Default values are for somites 1 and 4, as they mark the extent of the limb field in zebrafish.
#' @param dataframe time series dataframe
#' @param Asom Anterior somite group that you want to measure convergence for. Default value is 1
#' @param Psom Posterior somite group that you want to measure convergence for. Dfault value is 4
#' convergence()

convergence<-function(dataframe, Asom=1,Psom=4){

  #dataframe of mean values of X and Y of cells starting at each somite level
  a<-dataframe%>%
    group_by(Time,Embryo,Somite)%>%
    mutate(mean(X),mean(Y))%>% #calculate mean
    rename(meanX="mean(X)",meanY="mean(Y)")%>%
    select(Embryo, Time, Somite, meanX,meanY)%>%
    unique
  a<-as.data.frame(a)
  #value somite 1
  s1<-filter(a,Somite==Asom)
  s4<-filter(a,Somite==Psom)
  f<-s4%>%
    mutate(cX=meanX-s1$meanX, #calculate the difference between somite 1 and 4
           cY=meanY-s1$meanY)

  #normalize by dividing by the distance at time 1
  g<-filter(f, Time==1)
  k<-data.frame()
  for(n in 1:(max(dataframe$Embryo))){
    h<-filter(g, Embryo==n)
    i<-filter(f,Embryo==n)
    j<-i%>%
      mutate(convergenceX=cX/h$cX,
             convergenceY=cY/h$cY)
    k<-rbind(k,j)
  }
  k<-select(k,Embryo,Time, convergenceX,convergenceY)
  return(k)
}
