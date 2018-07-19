#' Function for calculating persistance
#'
#' This function calculates persistance, which is essentially a ratio of displacement over track length. It also calculates total track length. It relies on tracklength to function
#' @param df dataframe
#' @export



persistance.fun<-function(df){
  # calculate persistance
  a<-tracklength(df)
  #total displacement account for both x and y
  a1<-filter(df, Time==1)%>%
    rename(X1=X, Y1=Y)%>%
    select(Embryo, Track, X1, Y1) # this is an index for calculating displacement
  b<-left_join(df, a1)%>%
    mutate(total.disp=sqrt((X-X1)^2+(Y-Y1)^2))
  #calculate persisitance
  c<-left_join(b,a)%>%
    mutate(persistance=total.disp/track.length)%>%
    select(-X1,-Y1)
  return(c)

}
