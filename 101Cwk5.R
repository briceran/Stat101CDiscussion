# Stat 101C Discussion wk 5
# Part 1
# Exercise with caret package

.libPaths()


install.packages("caret")
install.packages("kernlab")
library(caret)
library(kernlab)
data(spam)
inTrain<- createDataPartition(y=spam$type, p = 0.75, list = FALSE)
training<- spam[inTrain,]
testing<- spam[-inTrain,]
dim(training)



# Data Slicing
# how often a particular word appears 
set.seed(0423)
folds<-createFolds(y=spam$type, k = 10, list = TRUE, returnTrain = FALSE)
sapply(folds,length)
folds[[1]][1:10] #indices

modelFit<- train(type~.,data = training, method = "glm")
modelFit
modelFit$finalModel
predictions<-predict(modelFit,newdata=testing)
predictions
confusionMatrix(predictions,testing$type)
##########################################  awesome, right?
folds_resample<-createResample(y=spam$type,times = 10, list = TRUE)
sapply(folds_resample, length)
folds_resample[[1]][1:10] 


# centering and scaling
trainCapAve<- testing$capitalAve
trainCapAveS<- (trainCapAve - mean(trainCapAve))/sd(trainCapAve)
mean(trainCapAveS)
sd(trainCapAveS)
testCapAve<-testing$capitalAve
testCapAveS<-(testCapAve - mean(trainCapAve))/sd(trainCapAve)
mean(testCapAveS)
sd(testCapAveS)

# or
preObj<-preProcess(training[,-58],method=c("center","scale"))
trainCapAveS<- predict(preObj,training[,-58])$capitalAve
mean(trainCapAveS)
sd(trainCapAveS)


#####################################
# Part 2
# Creating a package

install.packages(c("devtools","roxygen2","testthat","knitr"))
# make sure you have a C compiler (Xcode) 
library(devtools)
has_devel()
# unique name that can be googled
# don't use both upper and lower case


# 1. File -> New Project
# 2. Choose New Directory 
# 3. Select R package
# 4.Give your package a name

# each project is isolated
# try F2 Ctrl- Alt-Shift-K  Help Keyboard Shortcuts
# follow @rstudiotips

#########################################################
