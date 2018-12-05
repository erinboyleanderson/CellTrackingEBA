#' Function for determining scatter
#'
#' This function calulcates scatter, which is one measure of how far apart embryos are over a time series. IT is essentially sd[t=n]/sd[t=1]
#' Note: scatterX is AP scatter, scatter Y is ML scatter PER EMBRYO
#' mscatterX is the mean scatterX and mscatterY is the MEAN scatter Y over all embryos.
#' seX is AP standard error, seY is ML standard error
#'
#' @param df time series dataframe
#' @export



scatterfun<-function(df){# would it be different if I grouped by embryo as well?
  a<-df%>%
    group_by(Embryo,genotype,Time)%>% # calculate scatter for each embryo in order to calc sd
    mutate(sdX=sd(X),sdY=sd(Y))%>%
    ungroup%>%
    select(Time, sdX,sdY, genotype, Embryo)%>%
    distinct # because there are many tracks for embryo, so we only need one set
  b<-filter(a, Time==1)%>%
    rename(sdX1=sdX,sdY1=sdY)%>%
    select(Embryo, genotype, sdX1,sdY1)
  a<-right_join(a,b)%>%
    group_by(genotype, Time, Embryo)%>%
    mutate(scatterX=sdX/sdX1,scatterY=sdY/sdY1)%>%
    ungroup%>%
    #select(genotype, Time, scatterX, scatterY)%>%
    group_by(genotype, Time)%>%
    mutate(mscatterX=mean(scatterX), # mean values of scatterX
           mscatterY=mean(scatterY), # mean values of scatterY
           seX=sd(scatterX)/sqrt(length(scatterX)),
           seY=sd(scatterY)/sqrt(length(scatterY)))
  return(a)
}
