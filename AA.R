# install.packages("pacman") # only run this once
library(pacman) # loads pacman
p_load(baseballr, dplyr, magrittr, psych, DT, openxlsx) # installs and/or loads required packages


p2021 <- fg_pitch_leaders(x = 2021, y = 2021, qual = 0) # download 2021 pitching leaderboards
View(p2021) # View downloaded data

# Here, we created a new file called fixIP.R, which was used to store the new function
# we created, called fixIP().

# After creating the fixIP() function, we load it into our current session
source("src/fixIP.R")

p2021$oldIP <- p2021$IP # save a backup of Fangraphs original IP column in new column called oldIP
p2021$IP <- fixIP(p2021$oldIP) # Run our function on the oldIP and overwrite the IP column

# Here, we created a new file called zPit.R, which was used to store the new function
# we created, called zPit().

# After creating the zPit() function, we load it into our current session
source("src/zPit.R")

p2021z <- zPit(p2021) # Create z-scores based on the data in p2021 and save it in a new object called z2021p
View(p2021z) # View newly created z-scores

# Take a subset of our data, order it according to z-score, and display it using datatable from the DT package
p2021z %>% # %>% is the magritt pipe. It sends what precedes it to be executed by what follows it.
  select(Name, Team, IP, W, SO, SV, ERA, WHIP, # pick the columns we want to keep
         zW, zSO, zSV, zERA, zWHIP, zPit) %>%
  arrange(desc(zPit)) %>% # order data set in descending order by zPit column
  datatable(filter = "top") %>% # use datatable and add a filter to the top
  formatRound(c("IP", "zW", "zSO", "zSV", "zERA", "zWHIP", "zPit"), 2) # Round the specified columnns to 2 decimal places

# If we want to save our resulting z-scores to an Excel file, we can use write.xlsx
write.xlsx(p2021z, "z-Scores for Pitchers.xlsx")

## Now do 2020 full season

p2020 <- fg_pitch_leaders(x = 2020, y = 2020, qual = 0)
p2020z <- zPit(p2020)

p2020z %>%
  select(Name, Team, IP, W, SO, SV, ERA, WHIP,
         zW, zSO, zSV, zERA, zWHIP, zPit) %>%
  arrange(desc(zPit)) %>%
  datatable(filter = "top") %>%
  formatRound(c("IP", "zW", "zSO", "zSV", "zERA", "zWHIP", "zPit"), 2)
