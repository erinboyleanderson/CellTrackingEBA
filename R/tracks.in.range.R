#' Function for determining the number of tracks in range
#'
#' This function gives the number of tracks in any tracking dataframe. (It's especially helpful because when selecting a subset of tracks within a certain range, sometimes you get tracks in the middle filtered out because the tracks aren't always exactly in numerical order, depending on how you track them)
#' @param dataframe Cellt racking dataframe, minimally must have one column named Embryo (to specify the embryo number) and one column named Track (to differentiate between different tracks)
#' @export
tracks.in.range<-function(dataframe){
  e<-data.frame()
  for(a in 1:max(dataframe$Embryo)){
    b<-filter(dataframe,Embryo==a)%>%
      select(Track)
    d<-length(unique(b$Track))
    c<-c(d,a)
    e<-rbind(e,c)
  }
  colnames(e)<-c("track #","Embryo")
  return(e)
}
