# 424Project

Application of Linear Discriminant Analysis: 
I decided to run a linear discriminant analysis to see if I could find variables that would easily separate what campaign people responded to. First, I combined AcceptCmp1, AcceptCmp2, AcceptCmp3, AcceptCmp4, and AcceptCmp5 into a new variable called Accepted. Then I went back and took away those variables from the dataset. I separated the data into testing and training sets, and then ran the linear discriminant analysis. 

I found out most of the data was in the no response group which was slightly concerning since I was unsure if it would be able to predict the categories well. After running the test, I was able to  confirm the model did not learn how to separate the categories well. The table showed that the only category it could predict mostly correct was no response. The scatter plot confirmed this and shows it was really able to only form one cluster. 

Then I sampled the NAs so the values were evenly distributed. I checked the loadings to see what variables contributed to LD1 and LD2 the most. I used the log of Income and TotalProducts. We also checked each variable against Accepted to see what separated the campaigns naturally. I found that LgIncome, LgTotalProducts, and Kidhome did have means that were different in each campaign. 
         
When I reran the linear discriminant analysis with LgIncome, LgTotalProducts, and Kidhome, the plot showed I was able to separate the data into a couple main clusters, however the overall accuracy was still under 50%. 

I tried running the analysis one more time with the factors from the factor analysis but I was still not able to seperate into the 5 categories or predict with overall accuracy more than 50%.   

Overall, the model was not able to find variables that would easily predict what campaign people responded to. The LDA plot was not in 5 clear clusters and the contingency table verified that the model guessed wrong more often than not. A few variables did have means that were able to separate what campaign people responded to and if they responded. The variables LgIncome and LgTotalsProducts were better at separating all the categories and Kidhome was better at separating the 3rd campaign and no response. I would recommend changing the campaigns to ones that would better match the customer. For example, the 3rd campaign may have focused on parents with kids like a Labor Day Sale (close to back to school time for children). You could have advertisements that focus on certain products like showing what new wines are in stock. 
