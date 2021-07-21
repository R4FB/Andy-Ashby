zBat <- function(x, bAB = 6725, bAVG = 0.2536){
  require(psych)
  require(magrittr)
  require(dplyr)
  
  bH <- bAB*bAVG
  
  out <- x %>%
    mutate(zR = psych::rescale(R, mean = 0, sd = 1, df = FALSE),
           zHR = psych::rescale(HR, mean = 0, sd = 1, df = FALSE),
           zRBI = psych::rescale(RBI, mean = 0, sd = 1, df = FALSE),
           zSB = psych::rescale(SB, mean = 0, sd = 1, df = FALSE),
           AVG_v_b = ((bH + H)/(bAB + AB)) - bAVG,
           zAVG = psych::rescale(AVG_v_b, mean = 0, sd = 1, df = FALSE),
           zTotal = zR + zHR + zRBI + zSB + zAVG,
           zBat = psych::rescale(zTotal, mean = 0, sd = 1, df = FALSE))
  
  return(out)
}
