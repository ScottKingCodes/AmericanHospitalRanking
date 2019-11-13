## This function reads the outcome-of-care-measures.csv file and returns a 
## character vector with the name of the hospital that has the best (ie: lowest)
## 30- day mortality for the specified outcome in that state
##
## The hospital name is the name provided in the Hospital.Name variable.
## The outcomes can be one of "heart attack", "heart failure", or "pneumonia"
## 
## Hospitals that do not have data on a particular outcome are excluded from the
## set of hospitals when deciding the rankings
##
## If there is a tie for the best hospital then the hospital names are sorted
## in alphabetical order and the first hospital in that set is chosen.
##
## If an invalid state value is passed to best, the function throws an error via the stop
## function with the message "invalid state".  If an invalid outcome value is passed to best
## the function should throw an error via the stop function with the message "invalid outcome"
## 
## This function uses library(plyr) for sorting

best <- function(state, outcome)
{
    library(plyr)
    ## Read outcome data
    data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    
    statedataset <- data$State[data$State == state]
    
    ##Check that state and outcome are valid
    if (length(statedataset) < 1)
    {
        stop("invalid state")
    }
    
    if (outcome == "heart attack")
    {
        specificoutcome <- 11
    }
    else if (outcome == "heart failure")
    {
        specificoutcome <- 17
    }
    else if (outcome == "pneumonia")
    {
        specificoutcome <- 23
    }
    else
    {
        stop("invalid outcome")
    }
    
   
    ##Remove duplicates and only return the data with the specific state
    specificdata <- data[(data$State == state & data[,specificoutcome] != "Not Available"),]
    
    ##Sort the data first based on the outcome then alphabetical
    sortdata <- arrange(specificdata,as.numeric(specificdata[,specificoutcome]),Hospital.Name)
    
    sortdata$Hospital.Name[1]
    
}