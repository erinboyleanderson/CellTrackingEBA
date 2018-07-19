#' Tracklength by somite
#'
#' This summarizes the tracklength by somite
#' @param df dataframe that is the output of tracklength
#' @export



tracklength.somite<-function(df){ #sometimes this still throws NAs but whatever
  a<- plyr::ddply(df, c( "Time","Somite"), summarise,
                  N    = length(track.length),
                  mean = mean(track.length),
                  sd   = sd(track.length),
                  se   = sd / sqrt(N))
  return(a)
}
