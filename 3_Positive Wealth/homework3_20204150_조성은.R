source('positive_wealth.R')

age <- 65
wealth <- 1000000
dep_rt <-0.02
mu <- 0.08
sigma <- 0.3
prop_stock <- 0.4
ann_dd <- 100000
years <- 10
num_sim <- 1000

cat("positive rate : ", positive_wealth(wealth, dep_rt, mu, sigma, prop_stock, ann_dd, years, num_sim))