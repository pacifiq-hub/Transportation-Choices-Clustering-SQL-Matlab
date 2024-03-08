# Mode-Transportation-Choices-Clustering-Logit-

This project is very dear to me, it dates back to June 2014. At that time, I was still a master's student publishing my master's thesis for the [Trans-OR laboratory at EPFL](https://transp-or.epfl.ch/research.php#:~:text=We%20identify%20new%20solutions%20to,the%20system%20as%20a%20whole.). I have always admired its director [Professor Michael Berliaire](https://en.wikipedia.org/wiki/Michel_Bierlaire), who gave me the passion I have today for data and its unlimited potential. At that time, the term _data science_ was very new, and my engineering school didn't have a specialized master's in that field. Research laboratories were the way to go to get proper learning in that field, and access to huge datasets.

[Click here to check the final technical report publication](https://github.com/pacifiq-hub/Mode-Transportation-Choices-Clustering-Logit-/blob/main/technical%20report.pdf) 
I also created at that time [a _code appendix_ file mostly in SQL and Matlab languages](https://github.com/pacifiq-hub/Mode-Transportation-Choices-Clustering-Logit-/blob/main/technical%20report.pdf) where I detail the queries and algorithm described in the technical report

## ![#f03c15](https://placehold.co/15x15/f03c15/f03c15.png) Problem Statement 

A bank's consumer credit department aims to simplify the decision-making process for home equity
lines of credit to be accepted. To do this, they will adopt the Equal Credit Opportunity Act's
guidelines to establish an empirically derived and statistically sound model for credit scoring. The
model will be based on the data obtained via the existing loan underwriting process from recent
applicants who have been given credit. The model will be built from predictive modeling techniques,
but the model created must be interpretable enough to provide a justification for any adverse
behavior (rejections).

## ![#c5f015](https://placehold.co/15x15/c5f015/c5f015.png) Objective

Build a classification model to predict clients who are likely to default on their loan and give
recommendations to the bank on the important features to consider while approving a loan.

## ![#1589F0](https://placehold.co/15x15/1589F0/1589F0.png) Proposed final solution

**_Comparison of performance for all machine learning models tested:_**

![image](https://github.com/pacifiq-hub/Loan-Default-Prediction-Decision-Trees/assets/46910395/a220ca3e-bb36-4491-be60-a89486ad71ba)

- **Based on the comparison, the best model in terms of performance is the XG Boost tuned classifier** that yielded the best recall score at 87% while showing no signs of overfitting.
- **But we've decided to choose the decision tree model though because it also yields a good recall score at almost 75%, an overall accuracy of 87%, but mostly consistency the features of importance.** It also generalized very well from train to test datasets.
- **We also like the interpretability of the decision tree that can be plotted when the XG boost is much harder to explain** and might create some concerns to the bank for the consistency of results.
- **Also the XG boost has much more randomness to it in the way it selects features and the number of times it selects them**, which also in turn impacts the way the algorithm converges to the optimal solution and the scores it provides to the features of importance. That can be controlled by seed or random_state parameters in XG Boost library, but it could make the bank business team uncomfortable in using such a complex model theoretically.
- **For that reason, we play the conservative card here**. We do have a difference of 12 pts in the recall score with our single decision tree, but that in turn gives us interpretability in the results and clarity to our bank decision makers and customers on the reasons of rejection.

**_Let's recap the pros of our model:_**

- **Simplicity**: It yields intuitive results that can be visualized and explained very easily. The model is also simple and will be applied on the overall set of features instead of randomly picked features across several trees.
- **No need for data preprocessing**: our decision tree require relatively little data preparation compared to the logistic regression that required us to scale the data. Our decision tree is also not affected by outliers and missing values to the extent that our logistic regression would be (or other clustering techniques).
- **Feature selection**: our decision tree inherently performed feature selection, using the most informative features first. This was not a major advantage here as the dataset is small, but in bigger datasets with many columns, the decision tree proves very useful at removing non-impactful features.
- **Good generalization to the test dataset**: Even though decision trees can overfit by creating overly complex trees that don't generalize well to new test datasets, here our tuning helped prune the tree to prevent overfitting.
- **Computation**: Our model computes very fast because it is only calculating one single decision tree, vs. the XG boost or random forest calculate several trees (to note that the XG Boost is much faster to compute than the random forest).

**_Let's recap the cons of our model:_**

- **Performance**: By being more conservative and focused on interpretability, we are also losing 12 points in the recall rate compared to the XG Boost, so performance here is definitely lowered. That's more than 1 person out of 10 we won't be able to detect as future defaulters because of our choice.
- **Reliance on the debt-to-income**: let's remind the debt-to-income ratio represents 80% of the importance in our mode, and that 20% of the values for that variable were missing. Definitely a risk here. The XG Boost was more balanced between the different features regarding their impact on the model.
- **Bias towards features with more levels**: Decision trees can be biased towards variables with more levels. Features with more unique values or categories may be favored over others, potentially leading to suboptimal trees.

**_How that solves the problem?_**

- **Our goal was to provide a machine learning algorithm able to predict borrowers that would default** based on the dataset provided, **which we're doing successfully 7.5 times out of 10**.
- **Our model had to be interpretable, and we have at hand a very clear plot of the decision tree** (see below), that any business executive would understand.
- **It's also clear what features are impacting the outcome of the classification** which is key for the bank due to government regulations.

#  

**_Final Decision Tree:_** 
<br/><br/>
![Decision Tree_Capstone Project](https://github.com/pacifiq-hub/Loan-Default-Prediction-Decision-Trees/assets/46910395/e25a3a2f-1464-42a6-9f79-494a6daf3170)
<br/><br/>

# 

**_And its features of importance:_** 
<br/><br/>
![Decision Tree_Features of importance_Capstone project](https://github.com/pacifiq-hub/Loan-Default-Prediction-Decision-Trees/assets/46910395/5886809b-63f8-41bc-ba87-52a8ee37c155)



## ![#1589F0](https://placehold.co/15x15/1589F0/1589F0.png) Refined insights

1. **We built a classifier model that can predict if a customer applying for a loan will default or not with** an f-1 score of 70%, **a recall of 75%** and an overall accuracy of 87%.

> **This is a great achievement as it means the bank will be able to detect if a customer will default successfully 7.5 times out of 10**. In addition, our overall f-1 score on the target class which is here the defaulting one yields 70%. The overall accuracy is also excellent a few points below 90%.   

2. Not surprisingly, **we found that the debt-to-income ratio is a critical feature of importance in all our models**. The model we retained the tuned single decision tree gives it an extremely high importance at 80%, when its impact is still the most important in our non-retained boosted model but more balanced at around 1/3 importance.

> **21% of the values for that variable were missing, which is too high. We will raise that concern to the bank and ensure we have a process in place to get as close to 100% collection for that feature**, as it's so important to the validity of our predictions. Knowing that 80% of our model depends on that variable, we can't afford to have missing values here. We should also have data quality processes in place to ensure we don't have incorrect values either.

3. **In terms of missing values, we also will group with DEBTINC, DELINQ as being a very important variable for our model**, and therefore the importance to get all values for this variable too. Currently we have around 10% of values missing for this variable when it is our second most important variable impacting our prediction.

> **Having delinquent credit lines was consistently a factor increasing the likelihood of defaulting**. Even though most borrowers didn't have any of those flagged. Having them meant riskier profiles for the bank. **On a side note, the DEROG variable also appeared to be impacting our model in the boosted tree, but not in the single decision tree**. It might be worth monitoring this variable in the future, see if it ends up also being a feature of importance in our single decision tree.

4. **Other credit score related features such as the number of recent credit inquiries or the number of credit lines did provide some insights and impact on the likelihood of defaulting, at a lower level than the previously mentioned variables though**.

> A confirmation here that features contributing to the credit score calculation all proved helpful in our model to assess the likelihood of defaulting. We will confirm this information to the bank.

5. **On data quality, we found out that DEBTINC and CLAGE had outliers that didn't seem valid**. We clipped reasonable values for these variables when the debt-to-income ratio was above 100, and the years of credit history above 70 years.

> **I would spend time discussing with the bank about this. For the debt-to-income ratio even if values between 50 and 100 are technically possible, I seriously doubt any bank would provide loans to such risky profiles**. So maybe that means our values are incorrect, which in turn impacts the quality of our model. The bank will probably be able to respond to that and clear our doubts or fix it.

6. **The variable that give us the job position and job longetivity didn't prove that impactful on our model**, which we were not necessarily anticipating. These variables can be good proxies for job stabilty, financial strength and security.

> **I would talk to the bank about the JOB variable that has 45% of values that are equivalent to missing, as they refer to 'Other' jobs**. In addition categories of values are not mutually exclusive making it confusing. For instance we have an Office category and a Executive position, one refers to the type of job, the other one to the seniority. Maybe a better collected variable could help us improve our model.

7. **The loan value didn't seem at first to have a significant impact on the chances of defaulting (i.e., in the EDA when analyzed on the overall population of borrowers), but it consistently came back as one of the features of importance to our model at a lesser degree though compared to other stronger features of importance**. Once we get deeper into the tree, this variable seems to have more impact for subgroups of our population.

8. In terms of the type of loan we are providing, which are only home improvement and debt consolidation loans, the bank mostly provides the latter one at 70% of loans provided. **We didn't see a meaningful impact of the type of loan on the outcome of defaulting**.

> I would still keep a closer eye to home improvement loans as our boosted model, the XG Boost, seemed to attribute a slight importance of this value on chances of defaulting. **Overall, it would make sense to ask the bank if they plan to provide more type of loans in the future, there are many opportunities out there.** If we already have data on customers, it could also make sense to get into providing mortgages that are more lucrative.

9. **A less important element but still worth mentioning, is that the home property value variable and the outstanding mortgage due are very correlated, and so together don't add more value to our problem**

> **If the bank has the ability to switch one of these variables for other ones, such as more socio-economic criteria on the borrower (e.g., salary, age, address), we would want to do it.** It seems the dataset comes from the Home Equity dataset (HMEQ), that might be a discussion to have with them.

## ![#1589F0](https://placehold.co/15x15/1589F0/1589F0.png) Further analysis

- We will monitor consistency of our recall performance on new unseen data which will require to get fresh unseen data. We will also run hypothesis testing on this performance metric to ensure it is robust and significant.
- We will run cross-validation to ensure consistency and stabilization of features of importance over time on different training datasets which is key to the bank.
- We also might be able to get more data points or new features in the future with our yearly budget of $100k, that would likely help improving the quality of the model.
- We didn't try a clustering method on that dataset due to the many outliers that would potentially decrease significantly the quality of our clusters. There are great clustering techniques though that we could still try.
- There are other complex decision tree alternatives such as the Adaboost or neural network decision trees that we could try. These would be interesting to compare to our more sophisticated XG Boost model even though their interpretability will still be a challenge for implementation at the bank.
- We corrected the imbalance of the dataset with weighting in all our models. There are other techniques that we could try such as SMOTE algorithm, which stands for Synthetic Minority Over-sampling Technique, that is able to "synthetize" data points thanks to closest neighbors features. This eventually balances the dataset artificially and lets the model learn on a perfectly balanced dataset.

For more information, you may [read the final report submitted with the Python script in this repository](https://github.com/pacifiq-hub/Loan-Default-Prediction-Decision-Trees/blob/main/Final%20Report_Loan%20Default%20Prediction_MFriederich.pdf) 
#  
