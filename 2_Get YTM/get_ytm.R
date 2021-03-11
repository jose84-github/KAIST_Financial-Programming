bond_price_ytm <- function(r,F,T,c,freq,PV){
  coupon <-F*c/freq
  t <- seq(1/freq, T,1/freq)
  dcf <- coupon*exp(-r*t)
  return(sum(dcf)+F*exp(-r*T)-PV)
}

get_ytm <- function(F,T,c,freq,PV){
  ytm <- uniroot(bond_price_ytm,F=F, T=T, c=c, freq=freq, PV=PV, interval=c(0,1))$root
  return(ytm)
}
