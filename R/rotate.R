#'Function for rotating embryo during registration process
#'
#'This function takes the output of the drift corrected dataframe and rotates it so that the embryo is oriented with anterior to the left and the midline towards the top of the page. It will also mirror image the  right limb field so that it is superimposed over the left.
#'@param drift.correctedDF output of rotate
#'@param somiteDF somite dataframe
#'@param bros number of bros
#'@param side dataframe consisting of the number of the embryo, the side (L vs R) and a multiplier (-1 or 1) based on if the embryo is on the L or R side
#'@export

rotate<-function(drift.correctedDF, somiteDF, bros,side){
  slopeDF<-slope(somiteDF) #calculate slope
  side<-arrange(side,Embryo)#make sure that side is ordered by embryo

  rotatedDF<-data.frame()
  for(n in 1:bros){
    a<-filter(drift.correctedDF,Embryo==n)
    b<-dplyr::filter(somiteDF,Embryo==n, boundary=="0-1")
    c<-dplyr::filter(somiteDF,Embryo==n,boundary=="5-6")

    #first translate so that the point of rotation (boundary 0-1) is at the origin
    a<-mutate(a,
              Xt=Xd-b$X,
              Yt=Yd-b$Y)

    #find slope to determine angle of rotation
    test<-filter(slopeDF,Embryo==n)
    ang<-(-atan(test$slope)) #need it to be negative so that it rotates the correct way

    #rotate around somite 0-1 boundary
    a$Xr=(a$Xt*cos(ang)-a$Yt*sin(ang)) # rotate around origin (som 0-1 bound)
    # if somite 5 is located before somite 1, this will transform the data so that it is now the opposite
    if(c$X<b$X){
      a$Xr<-(-1*a$Xr)
    }
    a$Xr<-a$Xr #shift som 0-1 bound
    a$Yr=(a$Xt*sin(ang)+a$Yt*cos(ang))*side$multiplier[n]+145 # to control for L versus R

    rotatedDF<-rbind.data.frame(rotatedDF,a)
    rm(a)
  }
  return(rotatedDF)
}
