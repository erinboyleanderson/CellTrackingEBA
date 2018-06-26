#' Tracklength by somite
#'
#' This summarizes the tracklength by somite
#' @param df dataframe that is the output of persitance.fun
#' @export
#' tracklength.somite()


tracklength.somite<-function(df){ #sometimes this still throws NAs but whatever
  a<- plyr::ddply(df, c( "Time","Somite"), summarise,
                  N    = length(sum.dist),
                  mean = mean(sum.dist),
                  sd   = sd(sum.dist),
                  se   = sd / sqrt(N))
  return(a)
}
