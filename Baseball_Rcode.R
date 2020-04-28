
######Loading the dataset

df<-read.csv('Pitch_Data_v3.csv')

### checking the head of the dataset

print(head(df))

### Checking the column names of the dataframe

print(colnames(df))

###Checking the data types of different columns

print(str(df))

##### Checkin if there are any missing values

library(Amelia)
print(missmap(df, main ='missing map' , col =c('yellow','black')))

###We can see that there are hardly any missing values in the dataset some of them are in the
##spin rate column but there's no point imputing them as the values are very less

is.null(df)
##Output is false this means there are no missing values

####Seeing the glossary and what we wanna predict it seems a lot of these columns will not be
##important to us to predict 

####Data wrangling and cleaning
##Checking whether a batter leaves a ball alone

 library(dplyr)
if(distinct(df , swing) == 1){
  print('There was a hit attempted at every ball')
}else 
{
  print('Some balls were left')
}
##So we can see that there was a hit attempted a every ball
##Now we can check other relevant columns

##Finding relation between Batsmans and pitchers height

## We see that there almost 0 correlation between these
library(ggplot2)
pl<-ggplot(df,aes(x=BatterHeight,y=PitcherHeight))+geom_point(alpha=0.5,fill='orange')
print(pl)

distinct(df,swing)
##there is no zero this means every pitch produces a swing which is wierd and some batter tend to leave
##some balls 
distinct(df,swingStrike)
##All values are zero this means there are no swing and miss which means every pitch was hit

df1<-select(df,c(calledStrike,swingStrike))
print(df1)
 ## Both columns have the same value which makes sense because if it's not a strike than it means
## it is also not a swing and a miss

print(distinct(df,calledStrike))
##It has all values as 0 which means there were no strikes

##After all this analysis it is clear to me that in this data there was no pitch in which there 
##was no swing from the batsman and there was no swing and miss ,so there can be a hit in 
##2 possible cases
##either H1b,H2b,H3b or hr should be true -a normal hit 
##All of H1b,H2b,H3b and hr are not happening and there is fielding error -non out hits
###Adding a sperate column Y which will describe whether it's a hit or not 

df$Y <- ifelse(df$h1b ==1 | df$h2b==1 | df$h3b==1 | df$hr==1 ,1,ifelse(
  (df$h1b ==0) & (df$h2b==0) & (df$h3b==0) & (df$hr==0) & (df$fieldingError==1),1,0
))

###After reading the glossary thoroughly and going through the definitions of each feature 
##We can remove the columns which might not be relevant for determing the probability of 
## a batted ball being a hit .

###After a in depth study of the glossary and understanding the rules of the game I found out that 
##these 29 features are the most relevant for our  modeling

###Removing the unnecessary features which may introduce noise in our dataset in our model
## Features such as game id etc are not relevant for our modeling
df3<-select(df,c(swingStrike,Outs,InningTop,PitchOfPA,PlateAppearance,Angle,BatterHeight,HorzRelAngle
                 ,HorzBreak,hbp,h2b,PinchHit,Extension,SpinRate,PitcherHeight,Bearing,StartSpeed,
                 h1b,VertRelAngle,Direction,BatterHitting,VertBreak,RelHeight,RelSide,
                 h3b,hr,PinchHit,PitcherThrowing,Balls,Strikes,Px,Pz,PitchType,Y,PitcherThrowing))

###Checking the datasets features datatypes and statistical details

print(str(df3))

print(summary(df3))

###Seeing the distribution of the StartSpeed among the bowlers
pl2<-ggplot(df3,aes(x=StartSpeed))+geom_histogram(fill='green',alpha=0.5,color='black')
print(pl2)
mean(df3$StartSpeed)

###Most of the Speeds are between 85  and 98 mph

##We can also see the distribution of left and right hand batsman and pitchers
pl3<-ggplot(df3,aes(x=BatterHitting))+geom_bar(fill=c('orange','red'),alpha=0.5,color='black')
print(pl3)

pl4<-ggplot(df3,aes(x=PitcherThrowing))+geom_bar(fill=c('blue','pink'),alpha=0.5,color='black')
print(pl4)
##It seems like the right handed batsman are more by about 25000
##it seems like the right hand pitchers are more but the difference is large as comapred to 
##batsman it's about 50000

##We can also see the distribution of the seam types
pl5<-ggplot(df3,aes(x=PitchType))+geom_bar(aes(fill=factor(PitchType)),alpha=0.5,color='black')
print(pl5)

###Fork ball stands out among the rest and almost half the pitchtypes have been forkball

###Removing all rows with na values in the cleaned dataset
any(is.na(df3))
#[1] TRUE
### Ignoring the Na values for better modeling
df4 <- na.omit(df3)
any(is.na(df4))
#[1] FALSE

###Splitting the data into training and testing set
library(caTools)

split <-sample.split(df4$Y, SplitRatio = 0.7)
#70 % of the data in the training set.

train<-subset(df4,split=T)

test<-subset(df4,split=F)

###Checking the correlation between different columns
library(corrgram)
num.cols<-sapply(df4, is.numeric)
cor.data <-cor(df4[,num.cols])
print(corrgram(df4))

#### The correlogram gives a good understanding about the correlation between various features

###Something to note here is that the in the correlation dataframe the standard dev is 0 

###As we have to predict binary outcome I chose the logistic regression model to be the best one 
##in this case

model<-glm(Y~.,data=train,family = binomial(link='logit'))
print(summary(model))

###We see that the most significant predictors are Direction ,Angle ,PlateApperance,Outs
##BatterHitting whehter he's left or right is also somewhat significant

###Recreating the model removing the columns which are not relevant or provide NA values only

df5<-select(df,c(Outs,InningTop,PitchOfPA,PlateAppearance,Angle,BatterHeight,HorzRelAngle
                 ,HorzBreak,h2b,Extension,SpinRate,PitcherHeight,Bearing,StartSpeed,
                 h1b,VertRelAngle,Direction,BatterHitting,VertBreak,RelHeight,RelSide,
                 h3b,hr,PitcherThrowing,Balls,Strikes,Px,Pz,Y,PitcherThrowing))

###Redoing the split on this new dataset

split <-sample.split(df5$Y, SplitRatio = 0.7)
#70 % of the data in the training set.

final.train<-subset(df5,split=T)

final.test<-subset(df5,split=F)

model_final<-glm(Y~.,data=final.train,family = binomial(link='logit'))
print(summary(model_final))

####Interprating the final revised model 

fitted.probabilities <-predict(model_final,final.test,type = 'response')
fitted.results<- ifelse(fitted.probabilities>0.5,1,0)

misclassError<- mean(fitted.results !=final.test$Y,na.rm = T)

accuracy <-1 - misclassError

print(accuracy)

### accuracy is 98.77 %

###Confusion Matrix of the model
print(table(final.test$Y,fitted.probabilities>0.5))

#### We can also use the step function to create a more corrected model which will use AIC values 
##to further improve the model

new.step.model<-step(model_final)

print(summary(new.step.model))

###Plate appearance, Vertbreak, Angle ,Direction are the most significant predictors in determining
##a batted ball being a hit

fitted.probabilities_step <-predict(new.step.model,final.test,type = 'response')
fitted.results_step<- ifelse(fitted.probabilities>0.5,1,0)

misclassError<- mean(fitted.results_step !=final.test$Y,na.rm = T)

accuracy <-1 - misclassError

print(accuracy)

### accuracy is 98.77 %

###Confusion Matrix of the model
print(table(final.test$Y,fitted.probabilities_step>0.5))

precision<-72868/(72868+1392)

print(precision)
###Precision is about 98.12 %

##################################################

##In the given dataset for example let's calculate probability (hit / batted ball) :

x<-nrow(df) ### Total batted balls
y<-nrow(filter(df,Y==1)) ## Total hits of all the batted balls

P<- y/x ##Probability (hit / batted ball)
print(P)  ####0.3573 approx.






