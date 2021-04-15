positive_wealth <- function(initial, rate, mu, vol, prop, draw, N, M){

  positive = 0
  negative = 0
  aft_dd = 0
  
  for(i in 1:M){
    
    temp_pt <- matrix(rep(0, N*8), N, 8)
    colnames(temp_pt) <- c("wealth_beg","stock","dep","eps","S_T","wealth_end","dd","aft_dd")
    
    for(j in 1:(N)){
      if(j == 1){
        wealth_beg <- initial
      } else{
        wealth_beg <- aft_dd
      }
      
      stock <- prop*wealth_beg
      dep <- wealth_beg - stock
      eps <- qnorm(runif(1))
      S_T <- stock*exp((mu-0.5*vol^2)*1+vol*eps*sqrt(1))
      
      wealth_end <- S_T+dep*(1+rate)
      dd <- draw
      aft_dd <- wealth_end-dd
      
      temp_pt[j,] <- c(wealth_beg, stock, dep, eps, S_T, wealth_end, dd, aft_dd)
    }
      
    if(aft_dd < 0){
      negative = negative + 1
    } else{
      positive = positive + 1
    }
    
  }
  
  percentage = (positive/M)
  
  return(percentage)
}