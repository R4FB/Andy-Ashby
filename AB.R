#install.packages("pacman") # only run this once
library(pacman)
p_load(baseballr, dplyr, magrittr, psych, DT, openxlsx)

b2021 <- fg_bat_leaders(x = 2021, y = 2021, qual = 0)
View(b2021)

p2021 <- fg_pitch_leaders(x = 2021, y = 2021, qual = 0)
View(p2021)

# Here, we created a new file called removePit.R, which was used to store the new function
# we created, called removePit().

# After creating the removePit() function, we load it into our current session

source("src/removePit.R")

b2021_noP <- removePit(b2021, p2021)
View(b2021_noP)

# Here, we created a new file called zBat.R, which was used to store the new function
# we created, called zBat().

# After creating the zBat() function, we load it into our current session

source("src/zBat.R")

b2021z <- zBat(b2021_noP)
View(b2021z)

b2021z %>%
  select(Name, Team, AB, R, HR, RBI, SB, AVG,
         zR, zHR, zRBI, zSB, zAVG, zBat) %>%
  arrange(desc(zBat)) %>%
  datatable(filter = "top") %>%
  formatRound(c("zR", "zHR", "zRBI", "zSB", "zAVG", "zBat"), 2)

# Generate z-scores for batters for the 2016 - 2021 seasons.

seasons <- 2016:2021

for(s in seasons){
  print(paste("Downloading", s, "batting data"))
  tempB <- fg_bat_leaders(x = s, y = s, qual = 0)
  print(paste("Downloading", s, "pitching data"))
  tempP <- fg_pitch_leaders(x = s, y = s, qual = 0)
  
  tempB_noP <- removePit(tempB, tempP)
  tempBz <- zBat(tempB_noP)
  
  if(s == first(seasons)){
    compiledBz <- tempBz
  } else {
    compiledBz <- bind_rows(compiledBz, tempBz)
  }
  
}

compiledBz %>%
  select(Seasons, Name, Team, AB, R, HR, RBI, SB, AVG,
         zR, zHR, zRBI, zSB, zAVG, zBat) %>%
  arrange(desc(zBat)) %>%
  datatable(filter = "top") %>%
  formatRound(c("zR", "zHR", "zRBI", "zSB", "zAVG", "zBat"), 2)

write.xlsx(compiledBz, "z-scores for Batters 2016-2021.xlsx")


