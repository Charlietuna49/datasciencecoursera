
best <- function(state, outcome){
 
  ##-------------------------------------------------------------------------------------
  ## Read outcome data
  ## elements are the columns needed for analysis
  ## Hosp, State, MI, CHF, Pneumonia
  elements <- c(2,7,11,19,27)
  outcomeOfCare <- read.csv("C:/Users/Charlietuna/datasciencecoursera/Assignment3/outcome-of-care-measures.csv", stringsAsFactors=FALSE)
  states <- unique(HospStateOutcomes["State"])## list of unique states
  HospStateOutcomes <- outcomeOfCare[,elements] ## only columns needed
  name<-names(HospStateOutcomes)<- c("Hosp", "State", "MI", "CHF", "Pneumonia")#rename the columns
  
  ##------------------------------------------------------------------------------------
  
  
  ## Check that state and outcome are valid
  if(sum(outcome == name)!= 1)stop("invalid outcome")
  if(sum(state==states)!= 1) stop("invalid state")
  
  
  
  
  ## Return hospital name in that state with lowest 30- day death
  ## rate
  
  
  
}