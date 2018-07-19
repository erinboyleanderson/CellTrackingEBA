#'Function for determining the total length of a track at any point
#'
#' This function determines the total length of a track at any given time point. It does it by adding up the individual distances that each cell has moved between each time point.
#'
#' @param df dataframe, must contain X, Y, Time, Embryo, Track columns
#' @export

tracklength<-function(df){
  a<-df%>%
    group_by(Embryo, Track)%>%
    mutate(Xp=dplyr::lag(X, order_by=Time),
           Yp=dplyr::lag(Y, order_by=Time))%>% # creates a series of data where Xp= Xn-1 and Yp=Yn-1, EXCEPT at the t=1 points
    mutate(insta.dist=sqrt((Xp-X)^2+(Yp-Y)^2))# calculate distance
  a[is.na(a)]<-0 # replace NA with 0
  a<-a%>%
    mutate(track.length=cumsum(insta.dist))%>%
    select(-X,-Y, -Xp, -Yp)%>%
    ungroup
  return(a)
}
