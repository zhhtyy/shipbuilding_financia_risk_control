library(readr)
library(tseries)
library(bootstrap)
library(stats)
library(fpp2)
library(ggplot2)
library(randomForest)
library(dplyr)
library(purrr)
library(ggfortify)
library(rpart)


train_set <- read_csv("train_set.csv")
train_set2 <- diff(train_set)

train_set = ts(train_set, start = 2000, frequency = 252)

fit_snaive <- function(input.data){
  
  dev.new()
  fit_DJ = snaive(input.data)
  print(summary(fit_DJ))
  checkresiduals(fit_DJ)
  
}
fit_stlf <- function(input.data){
  
  dev.new()
  fit_DJ = stlf(input.data)
  print(summary(fit_DJ))
  checkresiduals(fit_DJ)
  
}

#data input 
normal_test<- function(input.data,alpha=0.05,picplot=TRUE){
  if(picplot==TRUE){#graph drawing
    dev.new()#open a new window
    par(mfrow=c(2,1))
    
    #Q-Q plot
    qqnorm(input.data,main="qq plot")
    qqline(input.data)
    
    #density curve comparison
    hist(input.data,freq=F,main="density rectangle box")
    #ist(input.data,freq=F,main="density rectangle box",ylim = c(0,0.5))# back up line if not workable
    lines(density(input.data),col="blue") #density estimation line
    x<-seq(min(input.data),max(input.data),0.0001)
    #seq() set as 0.0001
    lines(x,dnorm(x,mean(input.data),sd(input.data)),col="red") 
    #normal distribution with mean and standard diviation
  
  #Shapiro-Wilk test on the data
  shapiro_result<- shapiro.test(input.data)
  if(shapiro_result$p.value>alpha){
    print(paste("success:applys to normal distribution,p.value=",shapiro_result$p.value,">",alpha))    
  }else{
    print(paste("error:not according to normal distribution,p.value=",shapiro_result$p.value,"<=",alpha))
  }
  shapiro_result
}
}

normal_test(train_set)
fit_snaive(train_set)
fit_stlf(train_set)

  




