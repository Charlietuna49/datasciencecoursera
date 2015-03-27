rankall <- function(outcome, num = "best") {
  
  ##-------------------------------------------------------------------------------------
  ## Read outcome data
  ## elements are the columns needed for analysis
  ## Hosp, State, MI, CHF, Pneumonia
  elements <- c(2,7,11,17,23)
  outcomeOfCare <- read.csv("C:/Users/Charlietuna/datasciencecoursera/Assignment3/outcome-of-care-measures.csv", stringsAsFactors=FALSE)
  
  
  ##HospStateOutcomes<-head(HospStateOutcomes)
  
  
  outComeName<-c("heart attack","heart failure","pneumonia")
  states <- unique(HospStateOutcomes["State"])## list of unique states
  
  states<-sort(c(t(states))) #change 1 element list to 1 row
  ##print(states)
  ##stop("states")




##-------------------------------------------------------------------------------------------


outState<-NULL
outHosp<-NULL


for(state in states){
    
    ##print(state)
    ##if(state=="CA")stop("CA")
    HospStateOutcomes <- outcomeOfCare[,elements] ## only columns needed0 
    name<-names(HospStateOutcomes)<- c("Hosp", "State", "heart attack", "heart failure", "pneumonia")#rename the columns#######    
    ##print(HospStateOutcomes)
    ##stop("test")
  
  ## Check that state and outcome are valid
  if(sum(outcome == outComeName)!= 1)stop("invalid outcome")
  #if(sum(state==states)!= 1) stop("invalid state")
  

 
  HospStateOutcomes<-HospStateOutcomes[(HospStateOutcomes[,"State"])==state,]
  ##print(HospStateOutcomes)
  ##stop("test")
  ## change "Not Available" to NA
  HospStateOutcomes[(HospStateOutcomes[,outcome]=="Not Available"),outcome]<-NA

  ## change outcome column to numeric prior to sorting
  HospStateOutcomes[,outcome]<-as.numeric(HospStateOutcomes[,outcome])
  ##print(HospStateOutcomes)
  
  ## sort and eliminate NA data
  sortOrder<-order(HospStateOutcomes[,outcome],HospStateOutcomes[,"Hosp"],na.last=NA)
  HospStateOutcomes<-HospStateOutcomes[sortOrder,]
  #print(HospStateOutcomes)

  
  ## Return hospital name in that state with lowest 30- day death
  ## rate
  ##print(HospStateOutcomes[1,1])
  ##print(num)
  #print(state)
 numHosp<-nrow(HospStateOutcomes)
 rowNum<-numHosp
 #print("number of hospitals")
 #print(numHosp)
 #print(num)
 if(num=="best")rowNum<-1 ## set num = first hosptial
 if(num=="worst")rowNum<-numHosp ## set num = last hospital
 if(is.numeric(num))rowNum<-num
 if(rowNum>numHosp){
     outHosp<- c(outHosp,NA)
     outState<-c(outState,state)
     next    
 } 
 
 
 
  ##print(HospStateOutcomes[num,2])
  ##print(HospStateOutcomes[num,1])
  ##output<- c(output,HospStateOutcomes[num,1],state)
  ##print("row Number")
  ##print(rowNum)
  ##print(state)
  outState<-c(outState,state)
  ##print(mode(outState))
  ##if(is.numeric(num)) rowNum<-num
  outHosp<- c(outHosp,HospStateOutcomes[rowNum,1])
  #outHosp<- t(c(outHosp))
  ##print(outHosp)
  ##print(mode(outHosp))
  
 
 ## print(output)
  ##stop("test")
  ##
  }
outPut<-data.frame(outHosp,outState,stringsAsFactors=FALSE)
names(outPut)<-c("hospital","state")
return(outPut)
    ##print(outState)
    ##print(outHosp)
  ##------------------------------------------------------------------------------------  
  
  
}