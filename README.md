# Mode-Transportation-Choices-Clustering-Logit

This project is very dear to me, it dates back to June 2014. At that time, I was still a master's student publishing my master's thesis for the [Trans-OR laboratory at EPFL](https://transp-or.epfl.ch/research.php#:~:text=We%20identify%20new%20solutions%20to,the%20system%20as%20a%20whole.). I have always admired its director [Professor Michael Berliaire](https://en.wikipedia.org/wiki/Michel_Bierlaire), who gave me the passion I have today for data and its unlimited potential. At that time, the term _data science_ was very new, and my engineering school didn't have a specialized master's in that field. Research laboratories were the way to go to get proper learning in data, and access to huge datasets.

[Click here to check the final technical report publication](https://github.com/pacifiq-hub/Mode-Transportation-Choices-Clustering-Logit-/blob/main/technical%20report.pdf). 
I also created at that time [a _code appendix_ file mostly in SQL and Matlab languages](https://github.com/pacifiq-hub/Mode-Transportation-Choices-Clustering-Logit-/blob/main/code%20developed%20report.pdf) where I detail the queries and algorithm described in the technical report

## ![#f03c15](https://placehold.co/15x15/f03c15/f03c15.png) Abstract 

The widespread use of smartphones and their ability to collect longitudinal
data without increasing the burden of the traveler enable better monitoring, understanding
and analysis of travel behavior. In this thesis, we make as a first attempt a
mode choice model with smartphone data when data collection is passive. Our research
consists in identifying and solving arising issues, due to the nature of the data, in order
to derive a dataset suitable for mode choice analysis. The key components of the
proposed methodology concern the detection of trips, activities and identification of the
trip purpose based on smarthphone data, and common issues to mode choice modeling,
such as the determination of the chosen mode and missing attributes of the unchosen
alternative, are addressed as well. The derived dataset is further enriched by complementary
datasets including socio-economic and meteorological information. Estimation
results are consistent with intuition and relevant works from the literature, showing the
feasibility and potential of using smartphones for mode choice analysis. A smartphone
dataset collected in Lausanne is used to illustrate the issues and estimate the model.

## ![#f03c15](https://placehold.co/15x15/f03c15/f03c15.png) Available data 

In the late autumn 2008, the Nokia research center Lausanne (NRC) concludes that no
public dataset is matching its internal research needs which has triggered the motivation
to collect a comprehensive dataset gathering as much information as possible about
people, places and the interaction between people and places. Two years later, the data
collection campaign begins, involving a sample of 174 participants provided with smartphones
and ending in September 2011, a little over 20 months.

![image](https://github.com/pacifiq-hub/Mode-Transportation-Choices-Clustering-Logit/assets/46910395/c16047df-1d46-4d69-a2a1-4198cd487751)

The different data modalities collected with the client can be partitioned into 3 main categories:
 - **Position data**: GPS (when available), WLAN access point information (when
available), acceleration and cellular network information.
- **Social interaction data**: Call logs, short message logs and Bluetooth scanning
results.
- **Media creation data**: Locations where images have been captured, video shot,
music played. And information on Applications used with the Symbian OS.
Once uploaded in the server, data is anonymized by clearing real names of the users,
phone numbers, calendar information, Bluetoot, WLAN MAC addresses 2 and acoustic
data.

The quantity of data collected with the devices at the end of the campaign is large:
- 14 million GPS tags are recorded with different levels of accuracy within a range
from 5 meters to 400 meters.
- 44 million Wi-Fi records are collected and 77 % of this amount is localized.


## ![#c5f015](https://placehold.co/15x15/c5f015/c5f015.png) Discrete Choice Model 

Discrete choice models are used in transportation research among other numerous applications
that include econometrics and marketing. In the context of discrete choice
theory, the assumption is that an individual chooses one of the alternatives among all
the possible alternatives available which is defined as the exhaustive choice set. A common
example in transportation research is a person deciding which mode (car, bike,
transit, etc.) he will take take to go working. Basically, the assumption is that a person
(denoted by n) associates an unobserved utility Uni to each alternative (denoted by i,
with i ∈ Cn and Cn the choice set). This utility is not observable and is only known of
the individual. In this context the utility can be expressed by: 

![image](https://github.com/pacifiq-hub/Mode-Transportation-Choices-Clustering-Logit-/assets/46910395/d10cb0d6-fbd2-4f3c-a85c-222d36ec5e26)

Where xni correspond to the observed variables: attributes of the alternatives (travel
time, distance, cost, etc.) or the characteristic of the decision making agent (car availability,
seasonal ticket, age, gender, number of persons in the household), the decisionmaking
agent being the person, household or business making the choice. 



βni are unknown parameters to be estimated with the data. εni captures the remaining factors
that are not included as observed variables. This error term can come from various
sources (preferences are not homogeneous, incomplete information about the attributes
of the alternatives such as comfort, measurement errors, etc.). 

At this point, different forms of the model can be derived depending on the assumptions made on the density
function of the error component which is presented further down.
Chapter 2. Literature review 13 The behavior of the user is utility-maximizing, we assume he is perfectly rational and
therefore by weighting the positives and negatives, he chooses the alternative that provides
the highest utility:

![image](https://github.com/pacifiq-hub/Mode-Transportation-Choices-Clustering-Logit-/assets/46910395/d0b15fb6-d874-41c3-8ef6-fe90c624deab)

Where Pni is the probability that individual n chooses alternative i. This assumption is
commonly called the decision rule. For the estimation of the parameters (β values in
equation 2.1), the researcher collects data from surveys to gather choices and observed
explanatory variables of the decision-maker.
Parameters βi are finally estimated with a function called the maximum likelihood
estimator" that maximizes the probabilities for all the observations as shown in equation
2.3 where N is the total number of observations.

![image](https://github.com/pacifiq-hub/Mode-Transportation-Choices-Clustering-Logit-/assets/46910395/d350a682-6abe-438b-af37-026ffaf0a80e)


## ![#1589F0](https://placehold.co/15x15/1589F0/1589F0.png) Analysis of the results

The results are compared to the Swiss Microcensus 2010
(OFS et al., 2010) i.e., Federal Statistical Office (OFS). In this study, a questionnaire is submitted to Swiss workers to
know what are the reasons motivating their mode choice when they go to work given
that several mentions can be reported (see Fig. 5.1). The study has been conducted for
2835 tours where the soft mode is chosen, 6076 when private motorized mode is chosen
and 1608 tours when the public transport alternative is chosen. Following Figure shows the
result of the questionnaire: 

![image](https://github.com/pacifiq-hub/Mode-Transportation-Choices-Clustering-Logit-/assets/46910395/53fa4129-78dd-4611-9039-2bbfab957f88)

#

The results of the models are consistent with intuition and reach the same conclusions
than OFS et al. (2010). Important variables such as distance and time are consistent
as well as socio-economic variable age. Interestingly, whereas summer season motivates
users towards the SM alternative, weather variables are not in
uencing the use of soft
modes . 

We found rational explications of this difference with Sabir et al. (2010): The
authors show effects of temperature and wind on the choice of the bike but not walking
where he reports very small effects of the weather variables. Therefore, it may not be
relevant to compare the results as we have grouped walking and biking in the soft mode
alternative. Furthermore, their study was conducted in Netherlands and therefore we
can expect different sensitivities to weather between Swiss and Dutch population. Also,
their analyze include different activity based trips such as commuting trips, recreational
and sport trips or educational trips whereas we are focused on home to work trips.
Thus, we find more relevant the comparison with OFS et al. (2010) that has carried out
the questionnaire for the same activity purpose and population, and reached the same
conclusions.

Although the model is satisfying and reaches our expectations, we had to make assumptions
to overcome some issues. First, we assumed that all the workers had a car, a bike
and a driver license except for one user that reported he didn't have a car. Furthermore,
we assumed that a linear weighting based on the ratio mode time of the observation
would rigorously adjust its relative importance in the model. However, more subtle distribution
might be more appropriate to adjust the importance of the observation with
small ratio mode time even more penalized and high ratio mode time put forward.

Furthermore, by choosing the multinomial logit model, we assumed the model to be homoscedastic
across individuals and to have equal variances across alternatives. Therefore
we assume the choice of each observation to be independent of other choices. However,
this assumption might not be true in some situations. Indeed, we assumed that the way to work and the way back of a user were two independent observations. Although it is
rare to observe the outbound and return of a user the same day, it happens 45 times
and in this cases the mode choice of the return might be correlated to the mode choice
of the way to work. Furthermore, the snowball enrollment sampling as reported in 3.2
creates natural social connections in the sample and 16 of the participants over 26 are
working at EPFL. Therefore, mode choices of these users might be correlated in some
situations (e.g. for example if the users work in the same laboratory).

#

![image](https://github.com/pacifiq-hub/Mode-Transportation-Choices-Clustering-Logit-/assets/46910395/6556ffb4-c14e-4a05-8972-95b1824bb2ee)

#

![image](https://github.com/pacifiq-hub/Mode-Transportation-Choices-Clustering-Logit-/assets/46910395/c2204a0f-8ca8-438f-aeb8-43f0281709fc)

## ![#1589F0](https://placehold.co/15x15/1589F0/1589F0.png) Conclusions

Smartphones consist of a tremendous source of data collection provided with a rich set
of sensors (GPS, Wi-Fi, Bluetooth, GSM, etc.) and an overall good recording accuracy
for GPS and Wi-Fi. These devices have significantly reduced the cost and burden
of both surveying companies and participants by way of a data that is automatically
collected and stored in digital format. These improvements have enabled the recording
of longitudinal data by stretching out data collection campaigns over several months
without fatigue effects.

This project has investigated the challenges of using smartphone data for mode choice
modeling. These challenges included the detection of trips, activities and identification
of the trip purpose, the determination of the chosen mode and missing attributes of
the unchosen alternative. Given that GPS data was sparse, because of energy saving
issues of the device, more energy friendly Wi-Fi sensor, became a good alternative to
GPS when it was not available. Moreover, much more Wi-Fi records were collected than
GPS in places where the user goes frequently, which is especially the case for home and
work. Therefore, the identification of the trip purpose and the trip detection that was
relying on these home and work locations could be inferred only with Wi-Fi data. The
detection of stops relying on the available records during trips required both GPS and
Wi-Fi data. To obtain the travel mode used during the trips, we included the results
of the multimodal map-matching algorithm proposed by Chen (2013). 

The diffculty of detecting the mode with the sparse GPS dataset resulted in parts of trip where
travel modes could not be inferred. The issue was therefore addressed by weighting the
observations according to the percentage of the trip where the travel mode was known.
Issues specific to the Nokia dataset that were the missing socio-economics, or the missing
train trips, due to the unreported train network in the open street map of Lausanne,
might not remain in future data collection campaigns but had to be overcome in this
project too.

The issues identified were addressed in order to build a dataset suitable for the mode
choice model developed. Besides the derived smartphone dataset, other data sources
were utilized to impute missing attributes of the alternatives (Google directions), to add
characteristics of the participants (demographic questionnaire) and to include long term
effects of meteorology on the mode choice (MeteoSwiss weather archives).
Different hypothesis were tested in the process of building the model resulting in a model
specification that gives results consistent with intuition and literature. Travel time when
increasing had a negative impact on the choice of car and public transport alternative
whereas distance when decreasing was a reason motivating participants toward the soft
mode alternative. Socio-economic age was also consistent with our expectations: participants
aged over 45 had a disutility towards the soft mode alternative which we assumed
was due to the lack of comfort of this alternative compare to car and public transports.
Summer season had a positive effect on the number of participants choosing the soft
mode. 

Interestingly, we concluded that meteorological variables were not influencing
the mode choices of workers for their home to work trips which was also reported in
OFS et al. (2010).

In a context where smartphones are revolutionazing the way data is collected, we showed
the feasibility and potential of using smartphone data in the context of discrete choice
analysis.

for more details on the bibliography, [check the final technical report](https://github.com/pacifiq-hub/Mode-Transportation-Choices-Clustering-Logit/blob/main/technical%20report.pdf).

#  
