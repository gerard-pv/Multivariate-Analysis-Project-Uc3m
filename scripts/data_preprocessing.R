library(dplyr)
library(readr)

set.seed(100)
data <- read_csv('data/online+shoppers+purchasing+intention+dataset/online_shoppers_intention.csv')

data <- data %>%
  mutate(
    Month = as.factor(Month),
    Region = as.factor(Region),
    TrafficType = as.factor(TrafficType),
    VisitorType = as.factor(VisitorType),
    OperatingSystems = as.factor(OperatingSystems),
    Browser = as.factor(Browser),
    Weekend = as.factor(as.numeric(Weekend == 'TRUE')),
    Revenue = as.factor(as.numeric(Revenue == 'TRUE')),
    SpecialDay = as.factor(SpecialDay)
  ) %>%
  rename(
    AdministrativeDuration = Administrative_Duration,
    InformationalDuration = Informational_Duration,
    ProductRelatedDuration = ProductRelated_Duration
  ) %>% 
  sample_n(2000)


# Save Processed Data
saveRDS(data, 'data/R_datasets/processed_dataset.rds')



