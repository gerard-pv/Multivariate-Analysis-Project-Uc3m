play_tennis <- read.csv('/Users/despoinaiapona/Downloads/data/play_tennis.csv', stringsAsFactors = TRUE)
# Save as .rda file in the 'data' directory of your project
save(play_tennis, file = "data/play_tennis.rda")
library(rpart)
library(rpart.plot)
model <- rpart(PlayTennis ~ ., play_tennis,
               control = rpart.control(cp = 0, maxdepth = 4, minsplit = 1, 
                                       minbucket = 1))
rpart.plot(model)

#Smaller maxdepth keeps the decision tree simple, with fewer splits and levels. This makes the plot nice and easy to understand. On the flip side, a bigger maxdepth means more splits and a more complex tree with more leaves. That makes the plot bigger and harder to understand it.

num_matrix_from_df <- function(tennis_data){
  as.matrix(as.data.frame(lapply(tennis_data,
                                 function(x) as.integer(x)-1)))}
