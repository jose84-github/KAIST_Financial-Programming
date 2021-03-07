bond_price_ytm <- function(F, T, c, f, ytm){
  
  C <- F*(c/f)
  R <- ytm/f
  t <- T * f
  bond_price=0
  
  for (i in seq(1:t)){
    pv <- C / exp(R*i)
    bond_price = bond_price + pv
  }
  bond_price = bond_price + F / exp(R*t)
  
  return(bond_price)
}

bond_price_zero_rate <- function(F, T, c, f, zero){
  
  C <- F*(c/f)
  R <- zero/f
  t <- T * f
  bond_price=0
  
  for (i in seq(1:t)){
    pv <- C / exp(R[i]*i)
    bond_price = bond_price + pv
  }
  bond_price = bond_price + F / exp(R[t]*t)

  return(bond_price)
}