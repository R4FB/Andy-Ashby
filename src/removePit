removePit <- function(bat, pit){
  require(magrittr)
  require(dplyr)
  
  b_or_p <- bat %>%
    filter(playerid %in% pit$playerid) %>%
    select(playerid, Name, PA) %>%
    left_join(select(pit, playerid, Name, IP), by = c("playerid", "Name")) %>%
    mutate(Batter = ifelse(PA > IP, 1, 0))
  
  pitchers <- b_or_p %>%
    filter(Batter == 0) %>%
    pull(playerid)
  
  bat <- bat %>%
    filter(!playerid %in% pitchers)
  
  return(bat)
}
