#Data Import from Excel
library(readxl)
df<- read_excel("Portfolio Projects/Monthly Recession Indicators.xlsx")
View(df)

#Load Relevant Packages
library(fpp3)
library(ggplot2)
library(forecast)
library(tseries)
library(VAR.etp)
library(GGally)
library(vars)
library(tidyverse)

#Clean Up Data, make date row names
df<- df %>% remove_rownames %>% column_to_rownames(var="DATE")
view(df)

#Plot data
plot.ts(df)

#setting data as time series
coin<-as.ts(df$COIN)
house<-as.ts(df$HOUSE)
unemp<-as.ts(df$UNEMP)
spread<-as.ts(df$SPREAD)
indpro<-as.ts(df$INDPRO)
rec<-as.ts(df$REC)
lei<-as.ts(df$LEI)
stocks<-as.ts(df$STOCKS)

#ADF Tests for Non-stationarity
adf.test(coin)
adf.test(house)
adf.test(unemp)
adf.test(spread)
adf.test(indpro)
adf.test(rec)
adf.test(lei)
adf.test(stocks)

#Putting into data frame to plot correlations
d<-cbind.data.frame( coin, indpro, lei, spread, house, rec)

#scatterplots and correlations
d%>%
  GGally::ggpairs(columns=1:6)

#################################################################################################################
#VAR
VAR.select(d, type = "const", ic="aic", pmax=10) #select by lowest aic
vmodel<-VAR.est(d, p=10, type="const")$coef #estimate model
varforecast<-VAR.Fore(d, vmodel, p=10, h=12, type = "const") #forecast model
varforecast #forecast results

# Make predictions
predicted.classes <- ifelse(varforecast$rec > 0.5, "high chance", ".")
predicted.classes1 <- ifelse(varforecast$rec > 0.25, "moderate chance", "low chance")
predicted.classes
predicted.classes1

#graph
x=c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
plot(x,probabilities, type="n")
lines(x, probabilities, col="blue")

#Test#####################################################################################

#Data Import from Excel
library(readxl)
df<- read_excel("Portfolio Projects/monthly indicators test.xlsx")
View(df)

#Load Relevant Packages
library(fpp3)
library(ggplot2)
library(forecast)
library(tseries)
library(VAR.etp)
library(GGally)
library(vars)

#Clean Up Data, make date row names
df<- df %>% remove_rownames %>% column_to_rownames(var="DATE")
view(df)

#setting data as time series
date<-as.ts(df$date) 
coin<-as.ts(df$COIN)
house<-as.ts(df$HOUSE)
unemp<-as.ts(df$UNEMP)
spread<-as.ts(df$SPREAD)
indpro<-as.ts(df$INDPRO)
rec<-as.ts(df$REC)
lei<-as.ts(df$LEI)
stocks<-as.ts(df$STOCKS)


#plot data
plot(coin)
plot(house)
plot(unemp)
plot(spread)
plot(indpro)
plot(rec)
plot(lei)
plot(stocks)

#ADF Tests for Non-stationarity
adf.test(coin)
adf.test(house)
adf.test(unemp)
adf.test(spread)
adf.test(indpro)
adf.test(rec)
adf.test(lei)
adf.test(stocks)

#Putting into data frame to plot correlations
d<-cbind.data.frame( coin, indpro, lei, spread, house, unemp,  rec)

#scatterplots and correlations
d%>%
  GGally::ggpairs(columns=1:8)

#################################################################################################################
#VAR
VAR.select(d, type = "const", ic="aic", pmax=10) #select by lowest aic
vmodel<-VAR.est(d, p=9, type="const")$coef #estimate model
varforecast<-VAR.Fore(d, vmodel, p=9, h=12, type = "const") #forecast model
varforecast #forecast results

# Make predictions
predicted.classes <- ifelse(varforecast$rec > 0.5, "high chance", ".")
predicted.classes1 <- ifelse(varforecast$rec > 0.25, "moderate chance", "low chance")
predicted.classes
predicted.classes1

#graph
x=c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
plot(x,probabilities, type="n")
lines(x, probabilities, col="blue")

#graph
x=c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
plot(x,probabilities, type="n")
lines(x, probabilities, col="blue")