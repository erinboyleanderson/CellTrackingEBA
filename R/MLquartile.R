#'Function for dividing the ML positions
#'
#'This function divides the limb field into 4 ML quartiles based on position, with the most medial cells being labelled 4 and the most lateral cells labelled 1. It works on each embryo seperately.
#'@param dataframe a dataframe of drift and rotation corrected tracking values (probably output of rotate or label.somites)
#' @export

MLquartile<-function(dataframe){
  t1<-filter(dataframe, Time==1)
  t1.LF<-filter(t1,Somite>=1,Somite<=4) #find ML values only within the limb field for measurements, since this is the central area I am interested in

  #calculate and assign ML values
  range<-t1.LF%>%
    group_by(Embryo)%>%
    mutate(mean=mean(Y),# mean
           sd=sd(Y))%>% # find sd
    filter(Y>=mean-2*sd,Y<=mean+2*sd)%>% #filter out the points that are within 2 points of the mean
    mutate(max=max(Y), # find max and min
           min=min(Y),
           range=max-min,
           quarter=range/4, #divide ML axis into quarters by embryo
           q1.max=min+quarter,
           q2.max=q1.max+quarter,
           q3.max=q2.max+quarter,
           q4.max=q3.max+quarter)%>%
    select(Embryo, q1.max,q2.max,q3.max,q4.max,quarter)%>% # pick only the values I need to scale back down to a minimal dataset in order to map these values onto all resulting datapoints
    unique()%>% # find unique values/reduce data table to a reasonable size
    right_join(t1,by="Embryo")%>% #join to all Embryos including ones outside of LF
    mutate(MLpos=ifelse(Y<=q1.max,1, #assign ML position
                        ifelse(Y<=q2.max,2,
                               ifelse(Y<=q3.max,3,4))))%>%
    select(Embryo, Track,MLpos)
  # add onto dataframe
  combo<-left_join(dataframe,range,by=c("Embryo", "Track"))
  return(combo)
}
