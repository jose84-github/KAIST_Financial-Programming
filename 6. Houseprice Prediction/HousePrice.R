library(ggplot2)
library(dplyr)
library(psych)
library(stats)
library(naniar)
library(superml)
library(caret)
library(corrplot)
library(ggrepel)
library(randomForest)

source("Function.r")
train_Df <- read.csv("train.csv")
test_Df <- read.csv("test.csv")
options(scipen=100)

#1. EDA(Exploratory Data Analysis) #
str(train_Df)
str(test_Df)

head(train_Df)
head(test_Df)

summary(train_Df)

#### delete index column
train_Df <- del_col(train_Df, 1)
test_Df_ID <- test_Df[1]
test_Df <- del_col(test_Df, 1)

#### normalization
dist_graph(train_Df, "SalePrice", 0, 700000, 200000)
qqplot(train_Df, "SalePrice")

train_Df <- log_transf(train_Df, "SalePrice")

dist_graph(train_Df, "SalePrice", 0, 700000, 200000)
qqplot(train_Df, "SalePrice")

#2. Feature Engineering #
ntrain <- nrow(train_Df)
ntest <- nrow(test_Df)

all_data <- concat(train_Df, test_Df)

heat_map(all_data)
box_plot(all_data, "OverallQual", "SalePrice")
scat_plot(all_data, "GrLivArea", "SalePrice")

# all_data <- all_data[-c(524, 1299),]
scat_plot(all_data, "GrLivArea", "SalePrice")

#### missing value processing
gg_miss_var(all_data)
all_data <- miss_value(all_data)

#### type changing num to str
all_data <- ch_str(all_data, c("MSSubClass", "OverallCond", "YrSold", "MoSold"))

### new Variable Making
all_data[,"TotalSF"] <- all_data[,"TotalBsmtSF"]+all_data[,"X1stFlrSF"]+all_data[,"X2ndFlrSF"]
all_data <- swt_col(all_data, "SalePrice", match("SalePrice", names(all_data)))

#### label encoding process
cols = c('FireplaceQu', 'BsmtQual', 'BsmtCond', 
         'GarageQual', 'GarageCond','ExterQual',
         'ExterCond','HeatingQC', 'PoolQC', 
         'KitchenQual', 'BsmtFinType1','BsmtFinType2', 
         'Functional', 'Fence', 'BsmtExposure', 
         'GarageFinish','LandSlope','LotShape', 
         'PavedDrive', 'Street', 'Alley', 
         'CentralAir', 'MSSubClass','OverallCond',
         'YrSold', 'MoSold')

all_data <- label_enc(all_data, cols)

### checking Skewness for numeric variables
m_skew <- select_if(all_data,is.numeric) %>% describe() %>% arrange(desc(skew)) %>% head(10) %>% rownames()

all_data <- minmax_sc(all_data, m_skew)

all_data <- one_hot_enc(all_data)

train_Df <- all_data[1:ntrain, ]
test_Df <- all_data[(ntrain+1):nrow(all_data), ]

# Modeling

pred_SalePrice <- lass_model(train_Df, test_Df, "SalePrice")
result <- data.frame(ID = test_Df_ID, SalePrice=pred_SalePrice)
write.csv(result, file="result.csv", row.names=F)
