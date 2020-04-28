# Project Title: Whose line is it from Game of Thrones?
## Summary Video: [Click Here](https://www.youtube.com/watch?v=7IW09Dm7BFc)
## Team 6 members:
* Zhen Wang (Brandon)
* Tyler Mccluskey
* Jonathan Tang
* Rosanna Zhang
* Trong Shen

### Introduction:
Team 6 consists of a group of Game of Thrones (GOT) fanatics who want to join their passion in data science with GOT. We decided to pull an existing GOT script on Kaggle and perform data analysis, natural langauge processing, and machine learning to gain insights on this GOT script. 

### Source Data Set: 
* Game_of_Thrones_Script.csv* saved in this repository from [Kaggle](https://www.kaggle.com/dasbootstrapping/game-of-thrones-episode-data)
* We cleaned up the above csv from Kaggle and saved a clean version in our repository named "Game_of_Thrones_Clean.csv"

#### Research Questions:
1. What insights can we draw from Game of Throne characters' script?
2. Can we predict with our model which house the speaker of a given line belongs to?

#### Our work are summarized in two Jupyter Notebooks stored in this repository:
* For data analyis:
  - GOT_analytics_part_1.ipynb
* For Machine Learning/ Predictive Model:
  - GOT_predictive_model_part_2.ipynb 

#### Data Analysis
#### We performed data anlytics on all the season, and obtained some interesting findings:
* We found that speaking lines in the show remain somewhat consistent but dropped in the last season because the last season is more action-filled rather than dialogue-filled.
* House Stark had more speaking lines in the show in the first season, but then surrendered more lines to House Lannister and Targaryen as the show progresses.
* We found that majority of the speaking lines for every season are spoken by dead characters. Perhaps not dead in the season, but dead at some point in the show
* We showed a positive correlation between total salary paid to an actor/ actress vs number of words spoken by his/her character 
* Daenerys get paid the most dollar per word, while Tyrrion having spoken the most number of words.
* We created word cloud showing what words were most widely spoken based by each cahracter and each house
- Lannsiter's top words are father, king, and good
- Stark's top words are lord, father, and never
- Targaryen's tops words are dragon, take, and men

#### Predictive Model
#### To limit the scope of our predicitive model we decided to use only Season 1 and part of Season 2 data for our model. In addition, we limited our houses to 4 top houses based on number of lines spoken in season 1: Lannister, Stark, Targaryen, and Mormont. Our goal is to predicit, given a line, which house is the speaker from? 
#### Key findings:
* We extracted different features just based on the script:
  - Sentiment score: whether words used are postive, negative, or netural sentiment
  - 4 Word Scores: a rating of how popular each word in that line is spoken by a particular house (one for every house of interest)
  -Num_Words and Num_Words_per_line: count how many words are spoken in each row and each sentence
* We found that there is some distinction between houses in terms of sentiment score and the 4 word scores but very little for Num_Words and Num_Words_per_line. We decided to drop Num_Words and Num_Words_per_line for our predictive model.
* We utilzied Knn model with the 5 attibuted extracted one sentiment score and 4 word scores for 4 different houses. We obtained 53% accuracy with season 1 as train and test data, and an accuracy of 43% with season 1 as train data, but part of season 2 as test data.
* We also tried other machine learning models common for natural language processing. For these ones, the only input is bag-of-words or a matrix of words used with their frequency as their row data. Random Forest algorithm had a comparable accuracy of 42% with season 1 as train data and part of season 2 as test data
* Overall, it is difficult to predict which house speaker is from since there is limited feature to be extracted from script along and words commonly sometimes overlap across houses depending on the circumstance. 
* Possibel areas for improvement for our Knn model: 
  - Remove all neutral sentiment words to increase sentiment score disncticiton between lines
  - Remove popular words shared between houses
  - Extract or create more attributes to increase the model accuracy 

