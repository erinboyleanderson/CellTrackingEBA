#' Function for determining 2D displacement
#'
#' This function determines 2D displacement
#'
#' @param df dataframe of  X and Y values over Time
#' @export

displacement.XY<-function(df){
  b<-dplyr::filter(df,Time==1)
  a<-df%>%
    group_by(Time)%>%
    mutate(displacement=sqrt((X-b$X)^2+(Y-b$Y)^2))%>%
    ungroup
  a<-as.data.frame(a)
  return(a)
}
