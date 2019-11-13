# AmericanHospitalRanking
American Hospital Ranking

____________________________________________________________________________________________________
The best function reads the outcome-of-care-measures.csv file and returns a 
character vector with the name of the hospital that has the best (ie: lowest)
30- day mortality for the specified outcome in that state

The hospital name is the name provided in the Hospital.Name variable.
The outcomes can be one of "heart attack", "heart failure", or "pneumonia"
 
Hospitals that do not have data on a particular outcome are excluded from the
set of hospitals when deciding the rankings

If an invalid state value is passed to best, the function throws an error via the stop
function with the message "invalid state".  If an invalid outcome value is passed to best
the function should throw an error via the stop function with the message "invalid outcome"

____________________________________________________________________________________________________

The rankhospital function takes the state, outcome and ranking of a hospital in that state
using the data set outcome-care-measures.csv file and returns a character vector
with the name of the hospital that has the ranking specified by the num argument.

If there is a tie for the best hospital then the hospital names are sorted
in alphabetical order and the first hospital in that set is chosen.

If the number given by num is larger than the number of hospitals in that state, 
the function will return NA

___________________________________________________________________________________________________
The rankall function takes two arguments, an outcome and hospital ranking

The rankall function reads the outcome-of-care-measures.csv file and returns
a 2-column data frame containing the hospital in each state that has the ranking
specified in num

The function will return a value for every state (some may be NA)

The first column in the data frame is named hospital which contains the hospital name
The second column contains the state (2-character abbreviation) name

Hospitals that do not have data on a particular outcome are excluded from the set

If there is a tie for the best hospital then the hospital names are sorted
in alphabetical order and the first hospital in that set is chosen first.

These functions use library(plyr) for sorting

num can be "best", "worst" or a numerical value
