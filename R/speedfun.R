#' Speed function
#'
#' This function calculates the speed of the cells between each time point
#' @param df cell tracking dataframe
#' @param time final frame that you want to track
#' @export
#' speedfun()

speedfun<-function(df,time){
  e<-data.frame() #make the dataframe to fill out
  # insta.speed at t=1 should be 0, this is the clumsy way to make that happen
  c<-filter(df,Time==1)%>%
    select(Embryo, Time, Track, X, Y, Somite,MLpos)
  c$insta.speed<-0
  for(t in 2:time){
    a<-filter(df, Time==t-1)
    b<-filter(df,Time==t)
    d<-mutate(b, sqrt((X-a$X)^2)+(Y-a$Y)^2/8) #do I want to also calculate
    e<-rbind(e,d)
  }
  e<-rename(e,insta.speed="sqrt((X - a$X)^2) + (Y - a$Y)^2/8") #rename to something better
  e<-rbind(e,c) #add in the t=1 datapoints
}
