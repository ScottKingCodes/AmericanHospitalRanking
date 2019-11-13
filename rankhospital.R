## This function takes the state, outcome and ranking of a hospital in that state
## using the data set outcome-care-measures.csv file and returns a character vector
## with the name of the hospital that has the ranking specified by the num argument.
##
## If there is a tie for the best hospital then the hospital names are sorted
## in alphabetical order and the first hospital in that set is chosen.
##
## If the number given by num is larger than the number of hospitals in that state, 
## the function will return NA
##
## num can be "best", "worst" or a numerical value
##
## This function uses library(plyr) for sorting

rankhospital <- function(state, outcome, num = "best")
{
    library(plyr)
    ## Read outcome data
    data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    
    ## Check that state and outcome are valid
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
    
    
    #set up ranknum as it may be a word or a number
    if (num == "best")
    {
        ranknum <- 1
    }
    else if (num == "worst")
    {
        ranknum <- length(specificdata$State)
    }
    else
    {
        ranknum <- num
    }
    
    ## Return hospital name in that state with the given rank 30-day death rate
    ##Sort the data first based on the outcome then alphabetical
    sortdata <- arrange(specificdata,as.numeric(specificdata[,specificoutcome]),Hospital.Name)
    
    if (ranknum > length(statedataset))
    {
        result <- NA
    }
    else
    {
        result <- sortdata$Hospital.Name[ranknum]
    }
    
    result
    
}