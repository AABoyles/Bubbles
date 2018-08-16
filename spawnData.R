library(dplyr)
library(readr)

n <- 1000

patients <- tibble(
  `Age at Diagnosis` = sample(c('13-19', '20-29', '30-39', '40-49', '50-59', '60+'), n, TRUE, c(1675, 14740, 9943, 6490, 4882, 1930)),
  `Sex at Birth` = sample(c('Male', 'Female'), n, TRUE, prob = c(.81, .19)),
  Race = sample(c("Caucasian (Non-Hispanic/Latinx)", "Hispanic/Latinx", "African-American", "Native American", "Asian-American", "Other"), n, TRUE, c(.1, .25, .44, .1, .01, .1)),
  Region = sample(c('South', 'Northeast', 'West', 'Midwest'), n, TRUE, c(16.8, 11.2, 10.2, 7.5)),
  PWID = sample(c("PWID", "Non-PWID"), n, TRUE, c(.09, .91))
)

patients %>%
  mutate(
    Gender = ifelse(`Sex at Birth` == 'Male',
      ifelse(runif(n()) < 0.017, 'Trans Woman', 'Cis Man'),
      ifelse(runif(n()) < 0.003, 'Trans Man', 'Cis Woman')
    ),
    MSM = ifelse(`Sex at Birth` == "Male" & runif(n()) < .8645, "MSM", "Non-MSM"),
    `Transmission Category` =
      ifelse(MSM == 'MSM' & PWID == 'PWID', 'MSM-IDU',
      ifelse(MSM == 'MSM', 'MSM',
      ifelse(PWID == 'PWID', 'PWID',
      ifelse(runif(n()) > .0089, 'HET', 'Other')))
    ),
    C2015 = ifelse(runif(n()) < .002, 'In County Diagnoses', ''),
    C2016 = ifelse(C2015 == 'In County Diagnoses' | runif(n()) < .001, 'In County Diagnoses', ''),
    C2017 = ifelse(runif(n()) < .001, 'In County Diagnoses', ''),
    C2018 = ifelse(C2017 == 'In County Diagnoses' | runif(n()) < .008, 'In County Diagnoses', ''),
    Cluster = sample(c('A', 'B', 'C', 'D', 'E', 'Not in a Molecular Cluster'), n, TRUE, c(21, 17, 13, 9, 5, n-65))
  ) -> patients

write_csv(patients, 'fakeinfectedpatients2.csv')
