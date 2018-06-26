#' Function for calculating slope
#'
#' This function calculates the slope of the embryo based on the somite/LPM boundaries in order to appropriately rotate the embryo.
#' @param somites Dataframe containing the boundary information. must include the following column names: Embryo, X, Y, boundary. Embryo is the number of the embryo, Boundary is the somite boundary, must be in the form 0-1, 1-2, etc where the numbers represent the somites that are being bound (ie 0-1 is the boundary between somite 0 and somite 1) ALSO MUST INCLUDE minimally boundary 0-1 and 5-6!
#' don't think I need to export because its all internal
#' @export
slope<-function(somites){
  a<-filter(somites, boundary=="0-1")
  b<-filter(somites,boundary=="5-6")
  slope<-mutate(a,(Y-b$Y)/(X-b$X))%>%
    rename(slope="(Y - b$Y)/(X - b$X)")%>%
    select(Embryo,slope)
  return(slope)
}
