#' Speed function
#'
#' This function calculates the speed of the cells between each time point
#' @param df cell tracking dataframe
#' @param interval time interval used, DEFAULT is 8 because my timepoints are all set to 8 minutes
#' @export


speedfun<-function(df, interval=8){
  a<-tracklength(df)%>%
    mutate(insta.speed=insta.dist/interval)%>%
    select(-insta.dist, -track.length)
  return(a)
}
