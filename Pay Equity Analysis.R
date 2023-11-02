library(haven)
WAGE1 <- read_dta("Econometrics/Data Files/WAGE1.DTA")
View(WAGE1)
library(quantreg)
library(GGally)

summary(WAGE1$wage)
summary(WAGE1$lwage)
summary(WAGE1$educ)
summary(WAGE1$exper)
summary(WAGE1$female)
summary(WAGE1$profocc)
hist(WAGE1$wage)
hist(WAGE1$lwage)

#scatterplots and correlations
WAGE1%>%
  GGally::ggpairs(columns=1:10)

WAGE1%>%
  GGally::ggpairs(columns=11:22)

#scatterplots to see if experience and tenure need to be quadratics
plot(WAGE1$lwage~WAGE1$exper)
abline(lm(lwage~exper, data = WAGE1))
lines(lowess(WAGE1$lwage~WAGE1$exper))

plot(WAGE1$lwage~WAGE1$tenure)
abline(lm(lwage~tenure, data = WAGE1))
lines(lowess(WAGE1$lwage~WAGE1$tenure))

library(quantreg)
#Regression Models
model_all_variables<-lm(lwage~educ+exper+tenure+nonwhite+female+married+numdep+smsa+northcen+south+west+construc+ndurman+trcommpu+trade+services+profserv+profocc+clerocc+servocc, data = WAGE1)
summary(model_all_variables)

model_quadradics<-lm(lwage~educ+exper+expersq+tenure+tenursq+nonwhite+female+married+numdep+smsa+northcen+south+west+construc+ndurman+trcommpu+trade+services+profserv+profocc+clerocc+servocc, data = WAGE1)
summary(model_quadradics)

model_onequad<-lm(lwage~educ+exper+expersq+tenure+nonwhite+female+married+numdep+smsa+northcen+south+west+construc+ndurman+trcommpu+trade+services+profserv+profocc+clerocc+servocc, data = WAGE1)
summary(model_onequad)

exp( -0.2675584)-1
exp(0.0010075)-1

#Quantile Regression
quantreg<-rq(lwage~female+married+educ+tenure+ndurman+trade+services+profocc+servocc, data = WAGE1, tau=0.5)
summary(quantreg)
