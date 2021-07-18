zPit <- function(x, bIP = 1260, bERA = 3.75, bWHIP = 1.19){
  require(psych)
  require(magrittr)
  require(dplyr)
  
  bER <- bERA*(bIP/9)
  bWH <- bWHIP*bIP
  x$WH <- x$BB + x$H
  
  out <- x %>%
    mutate(zW = psych::rescale(W, mean = 0, sd = 1, df = FALSE),
           zSO = psych::rescale(SO, mean = 0, sd = 1, df = FALSE),
           zSV = psych::rescale(SV, mean = 0, sd = 1, df = FALSE),
           ERA_v_b = bERA - ((bER + ER)/((bIP + IP)/9)),
           WHIP_v_b = bWHIP - ((bWH + WH)/(bIP + IP)),
           zERA = psych::rescale(ERA_v_b, mean = 0, sd = 1, df = FALSE),
           zWHIP = psych::rescale(WHIP_v_b, mean = 0, sd = 1, df = FALSE),
           zTotal = zW + zSO + zSV + zERA + zWHIP,
           zPit = psych::rescale(zTotal, mean = 0, sd = 1, df = FALSE))
  
  
  return(out)
}