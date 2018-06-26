#' Function for determining displacement
#'
#' This function calculates displacement over time. It specifically only calculates AP and ML displacement separately. For displacement in 2 dimensions, used displacement.XY
#' @param df time series tracking dataframe
#' @export


displacement.func<-function(df){
  b<-dplyr::filter(df,Time==1)
  a<-df%>%
    group_by(Time)%>%
    mutate(displacementX=X-b$X,
           displacementY=Y-b$Y)%>%
    mutate(avgXdisp=mean(displacementX),
           avgYdisp=mean(displacementY),
           seX=sd(displacementX)/sqrt(length(displacementX)),
           seY=sd(displacementY)/sqrt(length(displacementY)))%>%
    ungroup
  a<-as.data.frame(a)
  return(a)
}
