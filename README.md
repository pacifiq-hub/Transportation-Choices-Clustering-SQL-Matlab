# Food-Delivery-Exploratory-Data-Analysis

The [_Applied Data Science Program: Leveraging AI for Effective Decision-Making_](https://professional.mit.edu/course-catalog/applied-data-science-program-leveraging-ai-effective-decision-making)  is an intensive program covering courses of supervised and unsupervised learning, neural networks, graphs, decision trees, generative AI and recommendation systems focusing on theory, Python coding and application to different industries. It is taught by MIT professors, Munther Dahleh, Caroline Uhler, John N. Tsitsiklis, Stefanie Jegelka and Devavrat Shah. This GitHub repository consolidates my final Python script and main conclusions presented below that I submitted at the beginning of the program as my personal EDA project.  

[Click here to check the Python script](https://github.com/pacifiq-hub/Food_Delivery_Exploratory_Data_Analysis/blob/main/FDS_Project_FullCode_MFriederich.ipynb) 

## ![#f03c15](https://placehold.co/15x15/f03c15/f03c15.png) Problem Statement 

The number of restaurants in New York is increasing day by day. Lots of students and busy professionals rely on those restaurants due to their hectic lifestyles. Online food delivery service is a great option for them. It provides them with good food from their favorite restaurants. A food aggregator company FoodHub offers access to multiple restaurants through a single smartphone app.

The app allows the restaurants to receive a direct online order from a customer. The app assigns a delivery person from the company to pick up the order after it is confirmed by the restaurant. The delivery person then uses the map to reach the restaurant and waits for the food package. Once the food package is handed over to the delivery person, he/she confirms the pick-up in the app and travels to the customer's location to deliver the food. The delivery person confirms the drop-off in the app after delivering the food package to the customer. The customer can rate the order in the app. The food aggregator earns money by collecting a fixed margin of the delivery order from the restaurants.

## ![#c5f015](https://placehold.co/15x15/c5f015/c5f015.png) Objective

The food aggregator company has stored the data of the different orders made by the registered customers in their online portal. They want to analyze the data to get a fair idea about the demand of different restaurants which will help them in enhancing their customer experience. Perform the data analysis to find answers to these questions that will help the company to improve the business. 

## ![#1589F0](https://placehold.co/15x15/1589F0/1589F0.png) Sample of EDA Graphs (full EDA in Python script)

**_Most sucessfull restaurants by type of cuisine:_**

![image](https://github.com/pacifiq-hub/Food_Delivery_Exploratory_Data_Analysis/assets/46910395/8adaea0f-dc9a-4942-9182-5d79febeeff1)

- This grid of countplots regroups the franchises by type of cuisine, the fact we only kept the top 10 restaurant names is a choice, and we could increase at ease the parameter to more franchises if requested.
- The absolute #1 restaurant is the well-known fast-food gourmet burger franchise Shake Shack with more than 200 orders. Not surprisingly, for fast deliveries, Shake Shack is a perfect choice.
- In the Italian section, we have the Meatball Shop and in the Japanese the well-known Blue Ribbon Sushi that are both very popular restaurants with more than 100 orders each total.
- For the first group by type of cuisine, the top 3-4 restaurants are way ahead in terms of volumes of orders, which creates a big concentration of orders in some franchises: Shake Shack and Blue Ribbon Fried Chicken for American cuisine, Blue Ribbon Sushi + BR Sushi and Grill, Tao et.. This is good but also presents some risks in case some of these franchises decide to stop working with us.
- It is interesting to observe that the Middle Eastern and Mediterranean cuisines even though fairly popular, as being ranked #7 and #8 preferred cuisines, offer slightly less choice with respectively only 7 and 5 restaurants total. It would be important to monitor the evolution of the demand for these cuisines, in case they become more popular, it would make sense to sign new partnerships with more restaurants offering this type of cuisine

#

**_Top 20 restaurants:_**

![image](https://github.com/pacifiq-hub/Food_Delivery_Exploratory_Data_Analysis/assets/46910395/286d7159-8b49-4912-b807-b36252d15494)

- It is interesting to see that not all restaurants provide the same level of satisfaction to our customers. For instance, Shake Shack has an average rating of 4.28 vs. the meatball shop that comes right after is at 4.51.
- Bareburger for instance is at 4.06 which is a bit low. The franchise is well known in New York, so why are customers not as satisfied? Is it because of the food quality, or the delivery service? It would be worth deep diving there to know more.
- As a comparison Five Guys has an excellent 4.56 rating, and a similar positioning to Bareburger (i.e., selling gourmet fast-food burgers), why is Five Guys doing better? It is important here to get more information to understand why.
- The absolute best rating in this list is for Blue Ribbon Sushi Bar & Grill, that gets a solid 4.59. Sushi being a difficult cuisine because it's raw fish, so the logistics are usually harder to keep the fish fresh, I would also follow-up with the customers ordering there, to understand what makes them so happy about this restaurant.
- Restaurants that have lower scores include Parm, Redfarm Hudson and Rubirosa. Even though these mean ratings are satisfying for now (i.e., above 4.1), I would keep monitoring ratings for these franchises to ensure they don't decrease over time. If the restaurants go down in ratings, it's likely that our brand delivering their food will also be perceived as bad.

#

**_Delivery time on weekends and weekdays:_**

![image](https://github.com/pacifiq-hub/Food_Delivery_Exploratory_Data_Analysis/assets/46910395/08e04431-fee2-4ac9-916e-63347cf2963b)

'delivery_time' has a much higher spread in value in weekdays, with 75% of orders being higher than ~26 minutes on weekdays, when 75% of orders are actually delivered below ~26 minutes in weekends. This would require further investigation: it could be due to more traffic during the week, but we don't have this data.

#

**_Food prepartion time:_**

![image](https://github.com/pacifiq-hub/Food_Delivery_Exploratory_Data_Analysis/assets/46910395/79e5c359-6f45-4e1a-bed3-323a1033514a)

- We see that American, Japanese, Italian and Chinese are more evenly spread out between 20 and 35 minutes, which likely depends on the type of food ordered, cooked or just salads/sushis/raw food.
- Some cuisines have a much bigger spread with an elongated violin shape, for instance Southern, Vietnamese and Thai, which can be explained by potentially a bigger number of meals offered that require very different prep times
- Overall, Korean and Vietnamese seem to have a lowest average food prep time, but we wouldn't emphasize that insight too much, as the difference with longest mean cooking times such as American or Souhtern is only a few minutes.



## ![#1589F0](https://placehold.co/15x15/1589F0/1589F0.png) Conclusions

We analyzed a dataset of 1898 orders from New York. The dataset provided additional information on these orders such as customer ID, day of the week the order is placed, delivery and food preparation time, cuisine type, restaurants as well as ratings.

Based on the food delivery business model, it is natural to want reduced delivery times as much as possible as customers want their food fast and fresh. Ratings are an important variable to understand customer satisfaction. The variety of restaurants and cuisine types is also important as customers usually want choice when it comes to selecting their meal, and they want to see the restaurants or franchises they like. Finally weekly seasonality is key, as weekends and weekdays can affect demand and supply as well as traffic which in turn impacts delivery time. Thus, we looked all these variables into details and concluded that:

1. The food preparation time is fairly uniform across cuisine types and restaurants. We could also see some differences in preparation time depending on the type of cuisine which is expected and would depend on the meal's complexity to prepare.
2. The delivery time is around 24 minutes on average. It goes significantly up during weekdays vs. weekends. In addition, more than 10% of orders take more than 60 minutes total to get to the households once the order is placed.
3. The type of cuisine proposed is well varied with 14 different types of cuisines. The American, Japanese, Italian and Chinese are the most popular in terms of total orders placed (that's also the case on weekends). Shake Shake and Blue Ribbon franchises are the most popular in terms of orders placed on our platform.
4. The ratings overall are solid with a total average of 4.34 over 5 across all ratings provided. The top 20 of our best performing restaurants in terms of total orders placed are also very well rated, all above 4.0. Some are closer to 4, such as Bareburger, Parm, Redfarm Hudson, and Rubirosa. The percentage of ungraded orders is very high at around 40%, which in turn explains why only 4 restaurants have more than 50 ratings.
5. Almost 70% of orders cost less than $30 which goes against expectation, and means our orders are probably usually small and also ordered in smaller households, one or two max.
6. The top 3 most frequent customers have only made 9 to 13 orders, who will be eligible for a 20% discount voucher.
7. The food delivery company made a total revenue of 6,166.303 dollars which is based on different percentages retained on the cost of the order.

## ![#1589F0](https://placehold.co/15x15/1589F0/1589F0.png) Recommendations:

- The food delivery time goes up on weekdays, which should be monitored and investigated. For now, delivery time doesn't seem to be meaningfully impacting our ratings but this could change in the future.
- The type of cuisine is well diversified. Surprisingly the Italian cuisine which is a usual household favorite, is only the 3rd favorite cuisine. That could be because of the type of clients we're appealing too, or maybe because our choices of Italian restaurants are not appealing. As a reminder, Parm and Rubirosa which are our top restaurants have ratings closer to 4, which is good but below average.
- The ratings are overall solid, but I would keep monitoring the lower rated restaurants, including the Italians mentioned above and Bareburger that is the lowest rated restaurants in our top 20 most popular. If restaurants are poorly rated, eventually that will impact our brand image.
- Ratings' completion is too low at 60%, the food delivery company needs to improve this KPI, to increase the significance of the ratings collected, and adjust the strategy if needed. methods such as providing incentives or just improving the survey delivery method should be tested.
- It seems based on the cost of the order that we're appealing to smaller households, maybe one or two, which is understandable intuitively. This could be students, couples and roommates that don't want the hassle of cooking for only one or two people. This could be further confirmed with additional customer surveys and could help us adjust our media strategy to acquire more customers.
- Our top customers order frequency is low, or below expectation. This could be because the company is young, or because the churn is high in the industry. It is a competitive market, but controlling churn is vital to continue growing the company in a healthy way.
- The total revenues are still small, so we could think of creative ways of finetuning our percentage applied to orders so we can generate more revenues. Different things could be tested such as higher percentages for bigger orders, charging orders below 5 dollars, etc.

#  
