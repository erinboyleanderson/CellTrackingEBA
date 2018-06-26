#' Function for determining ML convergence
#'
#' This function should tell us if the ML cells are converging
#'
#'@param dataframe Time series dataframe.
#'@export

convergenceML<-function(dataframe){
  #dataframe of mean values of X and Y of cells starting at each somite level
  a<-dataframe%>%
    group_by(Time,Embryo,MLpos)%>%
    mutate(meanY=mean(Y))%>%
    select(Embryo, Time, MLpos, meanY)%>%
    unique
  a<-as.data.frame(a)
  #value diff quartiles
  s1<-filter(a,MLpos==1)
  s4<-filter(a,MLpos==4)
  f<-s4%>%
    mutate(cY=meanY-s1$meanY) # distance between the two farthest quartiles

  #normalize by dividing by the distance at time 1
  g<-filter(f, Time==1)
  k<-data.frame()
  for(n in 1:(max(dataframe$Embryo))){
    h<-filter(g, Embryo==n)
    i<-filter(f,Embryo==n)
    j<-i%>%
      mutate(convergenceY=cY/h$cY)
    k<-rbind(k,j)
  }
  k<-select(k,Embryo,Time,convergenceY)
  return(k)
}
