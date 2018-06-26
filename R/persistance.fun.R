#' Function for calculating persistance
#'
#' This function calculates persistance, which is essentially a ratio of displacement over track length. It also calculates total track length.
#' @param df dataframe
#' @param time final time point to calculate (frame)
#' @export



persistance.fun<-function(df,time){
  #first calculate distance
  e<-data.frame() #make the dataframe to fill out
  # insta.dist at t=1 should be 0, this is the clumsy way to make that happen
  c<-filter(df,Time==1)%>%
    select(Embryo, Time, Track, X, Y, Somite,MLpos)
  c$insta.dist<-0  #makes distance at time 1 = 0
  for(t in 2:time){
    a<-filter(df, Time==t-1)
    b<-filter(df,Time==t)
    d<-dplyr::mutate(b, (sqrt((X-a$X)^2)+(Y-a$Y)^2)) #this gives us the distance between each point
    e<-rbind(e,d)
  }
  e<-rename(e,insta.dist="(sqrt((X - a$X)^2) + (Y - a$Y)^2)")
  e<-rbind(e,c) #add in the time1 data point

  g<-group_by(e,Embryo,Track)%>% # need to group by first
    mutate(cumsum(insta.dist))%>% #this gives cumulative sums and solves so many of my R questions
    rename(sum.dist="cumsum(insta.dist)")
  g<-as.data.frame(g) #make it back into a dataframe

  #total displacement account for both x and y
  k<-data.frame()
  for(t in 1:time){
    h<-filter(g,Time==1)
    i<-filter(g,Time==t)
    j<-mutate(i,sqrt((X-h$X)^2+(Y-h$Y)^2))%>%
      rename(total.disp="sqrt((X - h$X)^2 + (Y - h$Y)^2)")
    k<-rbind(k,j)
  }
  # calculate persistance
  l<-mutate(k,total.disp/sum.dist)%>%
    rename(persistance="total.disp/sum.dist")%>%
    select(Embryo,Track,Time,Somite,MLpos,sum.dist,persistance) #later I might need to go back and get the X and Y coordinates but maybe not
  return(l)


}
