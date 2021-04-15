source('bond_price.R')
bond_price_ytm(100,3,0.04,4,0.01)
r<-seq(0.01, 0.03, 0.02/11)
bond_price_zero_rate(100,3,0.04,4,r)