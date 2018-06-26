#' Function for labelling LPM cells according to the somites they are adjacent to
#'
#' This function labels LPM cells with the somites that they are adjacent to
#' @param rotatedDF output from rotate
#' @param rotate.somitesDF output from rotate.somites
#' @param bros number of embryos in df
#' @export

label.somites<-function(rotatedDF,rotated.somitesDF,bros){
  rotatedDF<-rotatedDF%>%
    select(Embryo, Time, Track, Xr, Yr)%>% # select the subset that I want to use
    rename(X=Xr, Y=Yr) #update rotated embryos so the final values are the X values
  labelled<-data.frame() # df of all tracks by starting somite value
  for(n in 1:bros){
    a<-filter(rotatedDF,Embryo==n,Time==1)
    c<-filter(rotated.somitesDF, Embryo==n) #select down to embryo boundary

    #select ones anterior to somite1
    d<-filter(c,boundary=="0-1")$Xr
    e<-filter(a,X<=d)
    h<-unique(e$Track)
    if(length(h)==0){ # to keep it from being empty and throwing an error
      h<-0
    }
    g<-data.frame(cbind(n,
                        c(h),
                        (0)))
    colnames(g)<-c("Embryo","Track","Somite")
    labelled<-rbind(labelled,g)
    rm(g)
    for(b in 2:6){
      # this will give me somites to somite 5, and not append a number to any tracks post somite 5
      bound<-paste(b-1,b,sep="-")
      bound2<-paste(b-2,b-1,sep="-")
      d<-filter(c,boundary==bound)$Xr
      d1<-filter(c,boundary==bound2)$Xr
      e<-filter(a,X<=d) %>%
        filter(X>d1) #to get the ones in between

      h<-unique(e$Track)# this gives us the track numbers of all embryos next to somite b at Time 1
      if(length(h)==0){ # to keep it from being empty and throwing an error
        h<-0
      }
      g<-data.frame(cbind(n,
                          c(h),
                          (b-1)))
      colnames(g)<-c("Embryo","Track","Somite")
      labelled<-rbind(labelled,g)
      rm(g)
    }
    #this will then get all the cells at somite 6 and beyond
    d<-filter(c,boundary=="5-6")
    e<-filter(a,X>d$Xr)

    h<-unique(e$Track)# this gives us the track numbers of all embryos next to somite b at Time 1
    if(length(h)==0){ # to keep it from being empty and throwing an error
      h<-0
    }
    g<-data.frame(cbind(n,
                        c(h),
                        (6)))
    colnames(g)<-c("Embryo","Track","Somite")
    labelled<-rbind(labelled,g)
    rm(g)
  }

  combo<-left_join(rotatedDF,labelled,by=c("Embryo","Track"))
  return(combo)
}
