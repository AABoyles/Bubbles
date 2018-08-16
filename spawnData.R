library(dplyr)
library(readr)

n <- 1000

patients <- tibble(
  `Age at Diagnosis` = sample(c('13-19', '20-29', '30-39', '40-49', '50-59', '60+'), n, TRUE, c(1675, 14740, 9943, 6490, 4882, 1930)),
  `Sex at Birth` = sample(c('Male', 'Female'), n, TRUE, prob = c(.81, .19)),
  `Race/Ethnicity` = sample(c("White", "Hispanic/Latinx", "Black", "American Indian/Alaska Native", "Asian", "Pacific Islander", "Multiple"), n, TRUE, c(10329, 9750, 17450, 243, 969, 48, 871)),
  Region = sample(c('South', 'Northeast', 'West', 'Midwest'), n, TRUE, c(16.8, 11.2, 10.2, 7.5)),
  PWID = sample(c("PWID", "Non-PWID"), n, TRUE, c(.09, .91))
)

patients %>%
  mutate(
    Gender = ifelse(`Sex at Birth` == 'Male',
      ifelse(runif(n()) < 0.02125, 'Trans Woman', 'Cis Man'),
      ifelse(runif(n()) < 0.015, 'Trans Man', 'Cis Woman')
    ),
    MSM = ifelse(`Sex at Birth` == "Male" & runif(n()) < .8645, "MSM", "Non-MSM"),
    `Transmission Category` =
      ifelse(MSM == 'MSM' & PWID == 'PWID', 'Gay and Bisexual Men who Inject Drugs',
      ifelse(MSM == 'MSM', 'Gay, Bisexual, and other MSM',
      ifelse(PWID == 'PWID', 'People who Inject Drugs',
      ifelse(runif(n()) > .1, 'Heterosexual', 'Other')))
    ),
    Year = sample(c("0Prior to 2015 or Not In County", 2015, 2016, 2017, 2018), n, TRUE, c(n-30, 4, 6, 3, 20)),
    Cluster = sample(c('A', 'B', 'C', 'D', 'E', 'Not in a Growing Cluster'), n, TRUE, c(21, 17, 13, 9, 5, n-65))
  ) %>%
  select(`Age at Diagnosis`, `Sex at Birth`, Gender, `Race/Ethnicity`, Region, `Transmission Category`, Year, Cluster) -> patients

write_csv(patients, 'fakeinfectedpatients2.csv')
