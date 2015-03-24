
best <- function(state, outcome){
 
  ##-------------------------------------------------------------------------------------
  ## Read outcome data
  ## elements are the columns needed for analysis
  ## Hosp, State, MI, CHF, Pneumonia
  elements <- c(2,7,11,19,23)
  outcomeOfCare <- read.csv("C:/Users/Charlietuna/datasciencecoursera/Assignment3/outcome-of-care-measures.csv", stringsAsFactors=FALSE)
  states <- unique(HospStateOutcomes["State"])## list of unique states
  HospStateOutcomes <- outcomeOfCare[,elements] ## only columns needed
  ##HospStateOutcomes<-head(HospStateOutcomes)
 
  name<-names(HospStateOutcomes)<- c("Hosp", "State", "heart attack", "heart failure", "pneumonia")#rename the columns
  outComeName<-c("heart attack","heart failure","pneumonia")
  ##print(HospStateOutcomes)
  
  ##------------------------------------------------------------------------------------
  
  
  ## Check that state and outcome are valid
  if(sum(outcome == outComeName)!= 1)stop("invalid outcome")
  if(sum(state==states)!= 1) stop("invalid state")
  ##t<-(HospStateOutcomes[,"State"])==state
  HospStateOutcomes<-HospStateOutcomes[(HospStateOutcomes[,"State"])==state,]
  ##print(HospStateOutcomes)
  ## change "Not Available" to NA
  HospStateOutcomes[(HospStateOutcomes[,outcome]=="Not Available"),outcome]<-NA
  ## change outcome column to numeric prior to sorting
  HospStateOutcomes[,outcome]<-as.numeric(HospStateOutcomes[,outcome])
  ##print(HospStateOutcomes)
  
  ## sort and eliminate NA data
  sortOrder<-order(HospStateOutcomes[,outcome],HospStateOutcomes[,"Hosp"],na.last=NA)
  HospStateOutcomes<-HospStateOutcomes[sortOrder,]
  ##print(HospStateOutcomes)
  
  ## Return hospital name in that state with lowest 30- day death
  ## rate
  HospStateOutcomes[1,1]
  ##
  
  
  
}