#'Function for rotating the somites
#'
#'This function rotates the somites so they are aligned correctly. This is important for labelling the cells with the somite identity later
#'@param somiteDF  Dataframe containing the boundary information. must include the following column names: Embryo, X, Y, boundary. Embryo is the number of the embryo, Boundary is the somite boundary, must be in the form 0-1, 1-2, etc where the numbers represent the somites that are being bound (ie 0-1 is the boundary between somite 0 and somite 1) ALSO MUST INCLUDE minimally boundary 0-1 and 5-6!
#'@param bros  number of embryos in the dataframe
#'@param side  dataframe consisting of the number of the embryo, the side (L vs R) and a multiplier (-1 or 1) based on if the embryo is on the L or R side
#'rotate.somites()
rotate.somites<-function(somiteDF,bros,side){
  slopeDF<-slope(somiteDF) #calculate slope
  side<-arrange(side,Embryo)#make sure that side is ordered by embryo
  rotatedsomites<-data.frame() #make df to fill

  for(n in 1:bros){
    b<-dplyr::filter(somiteDF,Embryo==n, boundary=="0-1")
    c<-dplyr::filter(somiteDF,Embryo==n,boundary=="5-6")
    #shift somites by somite 0-1 boundary so that 0-1 boundary is at (0,0)
    a1<-filter(somiteDF,Embryo==n)
    a1<-mutate(a1,X-b$X,Y-b$Y)%>%
      rename(Xt="X - b$X",
             Yt="Y - b$Y")

    #find slope to determine angle of rotation
    test<-filter(slopeDF,Embryo==n)
    ang<-(-atan(test$slope)) #need it to be negative so that it rotates the correct way

    #rotate around somite 0-1 boundary
    a1$Xr=(a1$Xt*cos(ang)-a1$Yt*sin(ang)) # rotate around origin (som 0-1 bound)
    # if somite 5 is located before somite 1, this will transform the data so that it is now the opposite
    if(c$X<b$X){
      a1$Xr<-(-1*a1$Xr)
    }
    a1$Xr<-a1$Xr #shift som 0-1 bound
    a1$Yr=(a1$Xt*sin(ang)+a1$Yt*cos(ang))*side$multiplier[n]+145 # to control for L versus R # 145 is to compensate to ML positions start roughly the same

    #import to DF
    rotatedsomites<-rbind(rotatedsomites,a1)
    rm(a1)
  }
  return(rotatedsomites)
}
