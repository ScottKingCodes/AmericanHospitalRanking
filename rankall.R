## rankall takes two arguments, an outcome and hospital ranking
##
## The function reads the outcome-of-care-measures.csv file and returns
## a 2-column data frame containing the hospital in each state that hs the ranking
## specified in num
## 
## The function will return a value for every state (some may be NA)
##
## The first column in the data frame is named hospital which contains the hospital name
## The second column contains the state (2-character abbreviation) name
##
## Hospitals that do not have data on a particular outcome are excluded from the set
##
## If there is a tie for the best hospital then the hospital names are sorted
## in alphabetical order and the first hospital in that set is chosen first.
##
## This function uses library(plyr) for sorting

rankall <- function(outcome, num = "best")
{
    library(plyr)
    ## Read outcome data
    data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    
    ## Check that the outcome is valid
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
    specificdata <- data[(data[,specificoutcome] != "Not Available"),]
    
    ##Sort the data first based on the outcome then alphabetical
    sortdata <- arrange(specificdata,State,as.numeric(specificdata[,specificoutcome]),Hospital.Name)
    
    allstates <- unique(sortdata$State)
    
   
   
    
    result <- data.frame(state = "TE", hospital = "Test hospital")
    
    ## For each state, find the hospital of the given rank
    for (i in 1:length(allstates))
    {
        specificstatedata <- sortdata[sortdata$State == allstates[i],]
        
        #set up ranknum as it may be a word or a number
        if (num == "best")
        {
            ranknum <- 1
        }
        else if (num == "worst")
        {
            ranknum <- length(specificstatedata$State)
        }
        else
        {
            ranknum <- num
        }
        
        if (ranknum > length(specificstatedata))
        {
            hospitalname <- NA
        }
        else
        {
            hospitalname <- specificstatedata$Hospital.Name[ranknum]
        }
        rankedhospital <- data.frame(state = allstates[i], hospital = hospitalname)
        result <- rbind(result,rankedhospital)
    }
    
    result <- result[result$state != "TE",]
    
    ## Return a data frame with the hospital names and the
    ## (abbreviated) state name
    result
    
}