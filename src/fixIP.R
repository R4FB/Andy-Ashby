fixIP <- function(oldIP){
  
  # Function that takes Fangraphs innings pitched
  # (in the format of 10.1 or 90.2) and converts
  # them to thirds of an inning.
  # So, X.1 becomes X.3333333
  # and Y.2 becomes Y.6666667
  
  # This function separates the whole number
  # from the decimal (.1 or .2)
  # It then multiplies the decimal by 3 & 1/3
  # to convert into 1/3 or 2/3 of an inning.
  # Then, the whole number is added back to 
  # the partial inning, and that's what the function
  # returns.
  
  wholeIP <- floor(oldIP)
  oldPartialIP <- oldIP - wholeIP
  newPartialIP <- oldPartialIP * (10/3)
  newIP <- wholeIP + newPartialIP
  
  return(newIP)
}


#fixIP(40.1)
#fixIP(100.2)
#fixIP(90)
