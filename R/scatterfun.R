#' Function for determining scatter
#'
#' This function calulcates scatter, which is one measure of how far apart embryos are over a time series. IT is essentially sd[t=n]/sd[t=1]
#' @param df time series dataframe
#' @export



scatterfun<-function(df){# would it be different if I grouped by embryo as well?
  a<-df%>%
    group_by(genotype,Time)%>%
    mutate(sd(X),sd(Y))%>%
    ungroup%>%
    select(Time, 'sd(X)','sd(Y)')%>%
    distinct%>% #removes duplicates
    rename(sdX="sd(X)",sdY="sd(Y)")
  a<-a%>%
    mutate(sdX/a$sdX[1],sdY/a$sdY[1])%>%
    rename(scatterX=`sdX/a$sdX[1]`,scatterY=`sdY/a$sdY[1]`)%>%
    mutate(seX=sd(scatterX)/sqrt(length(scatterX)),
           seY=sd(scatterY)/sqrt(length(scatterY)))
  return(a)
}
