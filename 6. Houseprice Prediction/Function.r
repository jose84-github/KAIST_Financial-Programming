
# Delecte Column Function
del_col <- function(dataframe, i){
  df <- dataframe
  
  cat("Dataframe Size (Before) : ", dim(df),"\n")
  df <- df[,-i]
  cat("Dataframe Size (after) : ", dim(df))
  
  return(df)
}

# Density Distribution Graph Function
dist_graph <- function(dataframe, target, init, end, step){
  df <- dataframe
  ggplot(df, aes_string(target)) + geom_density(fill='red')+ggtitle("Density Plot, SalePrice")+scale_x_continuous(breaks=seq(init, end, step))
}

# QQplot Graph Function
qqplot <- function(dataframe, target){
  df <- dataframe
  qqnorm(df[,target])
  qqline(df[,target], col='red')
}

# Log Transformation Function
log_transf <- function(dataframe, ft){
  df <- dataframe
  
  for(i in seq(1, length(ft))){
    # a <- ft[i]
    df[,ft[i]] <- round(log(df[,ft[i]]), 3)
  }
  
  return(df)
}

# Concatenate Function
concat <- function(dataframe1, dataframe2){
  df1 <- dataframe1
  df2 <- dataframe2
  
  df2$SalePrice <- NA

  all_data <- rbind(df1, df2)
  cat("Dataframe Size (df1) : ", dim(df1),"\n")
  cat("Dataframe Size (df2) : ", dim(df2),"\n")
  cat("Dataframe Size (all_data): ", dim(all_data),"\n")
  return(all_data)
}

# Heatmap Function
heat_map <- function(dataframe){
  df <- dataframe
  numericVars <- which(sapply(df, is.numeric))
  numericVarNames <- names(numericVars)
  cat('There are', length(numericVars), 'numeric variables')
  all_numVar <- df[, numericVars]
  cor_numVar <- cor(all_numVar, use='pairwise.complete.obs')
  cor_sorted <- as.matrix(sort(cor_numVar[,'SalePrice'], decreasing = TRUE))
  CorHigh <- names(which(apply(cor_sorted, 1, function(x) abs(x) > 0.5)))
  cor_numVar <- cor_numVar[CorHigh, CorHigh]
  corrplot.mixed(cor_numVar, 
                 tl.col = 'black',
                 tl.pos = 'lt',
                 number.cex = .7)
}

# box plot Function
box_plot <- function(dataframe, ft, target){
  df <- dataframe
  ggplot(df, aes_string(x=sprintf("factor(%s)",ft), y=target))+geom_boxplot(color="red")
}

# Scatter plot Function
scat_plot <- function(dataframe, ft, target){
  df <- dataframe
  ggplot(df, aes_string(x=ft, y=target))+geom_point(color="red")+geom_smooth(method='lm', se=FALSE, color='black', aes(group=1)) + geom_text_repel(aes(label = ifelse(df[,ft] > 4500,rownames(df), '')))
}

# Missing Value Treatment Function
miss_value <- function(dataframe){
  
  df <- dataframe
  
  none_vec <- c("PoolQC", "MiscFeature", "Alley", 
                "Fence", "FireplaceQu", "GarageType",
                "GarageFinish", "GarageQual", "GarageCond", 
                "BsmtQual", "BsmtCond", "BsmtExposure", 
                "BsmtFinType1", "BsmtFinType2", "MasVnrType", 
                "MSSubClass")
  
  zero_vec <- c("GarageYrBlt", "GarageArea", "GarageCars", 
                "BsmtFinSF1", "BsmtFinSF2","BsmtUnfSF",
                "TotalBsmtSF", "BsmtFullBath", "BsmtHalfBath", 
                "MasVnrArea","SalePrice")
  
  mod_vec <- c("MSZoning","Electrical", "KitchenQual", 
               "Exterior1st", "Exterior2nd","SaleType")
  
  df[,"LotFrontage"] = ifelse(!is.na(df[,"LotFrontage"]), df[,"LotFrontage"],round(median(df[,"LotFrontage"], na.rm=T), 2))
  
  df[,"Functional"] = ifelse(!is.na(df[,"Functional"]), df[,"Functional"],"Typ")
  
  for(i in seq(1,length(none_vec))){
    df[,none_vec[i]] = ifelse(!is.na(df[,none_vec[i]]), df[,none_vec[i]],"None")
  }
  
  for(i in seq(1,length(zero_vec))){
  df[,zero_vec[i]] = ifelse(!is.na(df[,zero_vec[i]]), df[,zero_vec[i]],0) 
  }
  
  for(i in seq(1,length(mod_vec))){
  df[,mod_vec[i]] = ifelse(!is.na(df[,mod_vec[i]]), df[,mod_vec[i]],getmode(df[,mod_vec[i]])) 
  }
  
  df <- df[, !names(df) %in% c("Utilities")]
  cat("Total Null : ", sum(is.na(df)))
  
  return(df)
}

# Get mode value Function
getmode <- function(v) {
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))]
}

# Change string function
ch_str <- function(dataframe, list){
  df <- dataframe
  
  for(i in seq(1, length(list))){
    df[,list[i]] <- as.character(df[,list[i]])    
  }

  return(df)
}

# Switch column Function

swt_col <- function(dataframe, ft1, ft1_pos){
  df <- dataframe
  SalePrice <- df[,ft1]
  df <- df[,-ft1_pos]
  df <- cbind(df, SalePrice)
  return(df)
}

# Label_Encoder Function
label_enc <- function(dataframe, list){
  df <- dataframe
  
  for(i in seq(1, length(list))){
    label <- LabelEncoder$new()
    df[,list[i]] <- label$fit_transform(df[,list[i]])
  }
  return(df)
}

# One Hot Encoding Function
one_hot_enc <- function(dataframe){
  df <- dataframe
  dmy <- dummyVars(~., data=df)
  df_new <- data.frame(predict(dmy, newdata=df))
  return(df_new)
}

# Minmax Scailing Function
minmax_sc <- function(dataframe, ft){
  df <- dataframe
  scale <- preProcess(df[, ft], method="range")
  new_df <- predict(scale, df)
  return(df)
}

# Feature Importance Calculation Function
feat_imp <- function(dataframe, ft){
  df <- dataframe
  set.seed(1234)
  quick_RF <- randomForest(x = df[,-79], y = df[,ft], ntree = 100, importance = TRUE)
  imp_RF <- importance(quick_RF)
  imp_DF <- data.frame(Variables = row.names(imp_RF), MSE = imp_RF[,1])
  imp_DF <- imp_DF[order(imp_DF$MSE, decreasing = TRUE),]
  
  ggplot(imp_DF[1:20,], aes(x = reorder(Variables, MSE), y = MSE, fill = MSE)) +
    geom_bar(stat = 'identity')+
    labs(x = 'Variables', y = '% increase MSE if variable is randomly permuted') +
    coord_flip() + theme(legend.position = 'none')
}

#lasso modeling function

lass_model <- function(df1, df2, target){
  set.seed(1234)
  my_control <- trainControl(method = 'cv', number = 5)
  lassoGrid <- expand.grid(alpha = 1, lambda = 0.015)
  
  lasso_mod <- train(x = df1[,1:(ncol(df1)-1)], y = df1[,target], method ='glmnet', trControl= my_control, tuneGrid = lassoGrid)
  
  # lasso_mod$bestTune
  
  cat("RMSE reult is : ",min(lasso_mod$results$RMSE))
  
  LassoPred <- predict(lasso_mod, df2)
  return (predictions_lasso <- exp(LassoPred))
}