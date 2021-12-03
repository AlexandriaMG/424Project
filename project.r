data = marketing
summary(data)

# Creating dummy variables for "Marital_Status" column
data$Married_Together <- ifelse(data$Marital_Status == 'Married/Together', 1, 0)
data$Single <- ifelse(dat$Marital_Status == 'Single', 1, 0)
data$Divorced <- ifelse(data$Marital_Status == 'Divorced', 1, 0)

# Factoring "Education" and then converting it to numeric
data$Education <- factor(data$Education)
data$Education <- as.numeric(data$Education)

# Taking out the characters and z variables (idk what they are???)
data <- data[-c(4,8,28,29)]

#taking out NAs
data <- na.omit(data) 

#Adding in Categorical 
data$Accepted <- as.factor(ifelse(data$AcceptedCmp1>0, '1st',
                          ifelse(data$AcceptedCmp2>0,  '2nd', 
                          ifelse(data$AcceptedCmp3>0,  '3rd', 
                          ifelse(data$AcceptedCmp4>0,'4th',
                          ifelse(data$AcceptedCmp5>0, '5th', 'No Response'))))))
data <- data[-c(20,21,22,23,24)]

# Splitting the data into training and test
dt = sort(sample(nrow(data), nrow(data)*.8))
train<-data[dt,]
test<-data[-dt,]

# Analyse 
cor(train)

summary(train)

# Pie Chart of Sales
percWine <- train$MntWines / train$TotalsProducts
percFruit <- train$MntFruits / train$TotalsProducts
percFish <- train$MntFishProducts / train$TotalsProducts
percGold <- train$MntGoldProds / train$TotalsProducts
percMeat <- train$MntMeatProducts / train$TotalsProducts
percSweet <- train$MntSweetProducts/ train$TotalsProducts

slices <- c(mean(percWine), mean(percFruit), mean(percMeat), mean(percFish),mean(percSweet), mean(percGold))
lbls <- c("Wine", "Fruit", "Meat", "Fish", "Sweet", "Gold")
lbls <- paste(lbls, round(slices, digits = 2)) # add percents to labels
lbls <- paste(lbls,"%",sep="") # ad % to labels
pie(slices,labels = lbls, col=rainbow(length(lbls)),
    main="Pie Chart of Total Sales")

# People model
Peoplemodel <- lm(TotalsProducts ~ log(Income) + Kidhome + Teenhome,data = train)
summary(Peoplemodel)

# Linear Discriminant 
library(MASS)
lda1 <- lda(Accepted ~ . , data= train)
print(lda1)
lda1_values2 <- predict(lda1, train)
table(train$Accepted,lda1_values2$class)
plot(lda1_values2$x[,1],lda1_values2$x[,2], col = train$Accepted)

lda1_values <- predict(lda1, test)
table(test$Accepted,lda1_values$class)
plot(lda1_values$x[,1],lda1_values$x[,2], col = test$Accepted)

#run without no response

data$Accepted <- as.factor(ifelse(data$AcceptedCmp1>0, '1st',
                                  ifelse(data$AcceptedCmp2>0,  '2nd', 
                                         ifelse(data$AcceptedCmp3>0,  '3rd', 
                                                ifelse(data$AcceptedCmp4>0,'4th',
                                                       ifelse(data$AcceptedCmp5>0, '5th', NA))))))
data <- data[-c(20,21,22,23,24)]
data <- data[!is.na(data$Accepted),]
dt = sort(sample(nrow(data), nrow(data)*.8))
train<-data[dt,]
test<-data[-dt,]
lda1 <- lda(Accepted ~ . , data= train)
print(lda1)
lda1_values <- predict(lda1, test)
table(test$Accepted,lda1_values$class)
plot(lda1_values$x[,1],lda1_values$x[,2], col = test$Accepted)

# Try it with scaled #
dt2 <- data
dt2$Accepted <- as.factor(ifelse(dt2$AcceptedCmp1>0, '1st',
                                  ifelse(dt2$AcceptedCmp2>0,  '2nd', 
                                         ifelse(dt2$AcceptedCmp3>0,  '3rd', 
                                                ifelse(dt2$AcceptedCmp4>0,'4th',
                                                       ifelse(dt2$AcceptedCmp5>0, '5th', 0))))))
NRs <- sample(nrow(dt2),175)
NR_Sample <- dt2[NRs,]
NR_Sample$Accepted <- ifelse(NR_Sample$Accepted==0, 'No Respnose',NA)
dt2$Accepted[dt2$Accepted ==0] <-NA
dt2 <- na.omit(dt2)
NR_Sample <- na.omit(NR_Sample)
dt2 <-rbind(dt2, NR_Sample)
dt2 <- dt2[-c(20,21,22,23,24)]
summary(dt2$Accepted)

dt2$LgIncome <- log(dt2$Income)
dt2$LgTotalsProducts <- log(dt2$TotalsProducts)
dt2$factors1 <- apply(fit$loadings[,1], dt2)

dt <- sort(sample(nrow(dt2), nrow(dt2)*.75))
train<-dt2[dt,]
test<-dt2[-dt,]


library(MASS)
lda3<- lda(train$Accepted ~ scale(LgIncome) + Teenhome + LgNumWebVisitsMonth  + NumCatalogPurchases+ scale(LgTotalsProducts))
print(lda3)
lda3_values2 <- predict(lda3, test)
table(test$Accepted,lda3_values2$class)
plot(lda3_values2$x[,1],lda3_values2$x[,2], col = test$Accepted) 








# LDA on Total Amount Purchased #
data$Spent <- as.factor(ifelse(data$TotalsProducts<100, 'under 100',
                                  ifelse(data$TotalsProducts<500,  '100-500', 
                                         ifelse(data$TotalsProducts<1000,  '500-1k', 
                                                       ifelse(data$TotalsProducts<2000, '1k-2k', 'Over 2K')))))

dt2 <- data
dt <- sort(sample(nrow(dt2), nrow(dt2)*.75))
train<-dt2[dt,]
test<-dt2[-dt,]
summary(dt2$Spent)

lda3<- lda(Spent ~ ., data= train)
print(lda3)
lda3_values2 <- predict(lda3, test)
table(test$Spent,lda3_values2$class)
plot(lda3_values2$x[,1],lda3_values2$x[,2], col = test$Spent) 

fit = factanal(d[,-1], 4)
print(fit$loadings, cutoff=0.4, sort=T)
print(fit)
