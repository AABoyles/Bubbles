library(dplyr)
library(readr)

n <- 1000

ages <- rnorm(n)
ages <- (ages - min(ages))*10 + 11

patients <- tibble(
  Age =  ages,
  Gender = sample(c('Male', 'Female'), n, TRUE),
  Orientation = sample(c("Striaght", "Gay", "Other"), n, TRUE),
  Race = sample(c("Caucasian (Non-Latinx)", "Latinx", "African-American", "Native American", "Asian-American", "Other"), n, TRUE),
  PWID = sample(c("PWID", "Non-PWID"), n, TRUE),
  PreP = sample(c("On PreP", "Not on PreP"), n, TRUE)
)

categories <- c('Low', 'Medium', 'High', 'Very High')

patients %>%
  mutate(
    MSM = ifelse(Gender == "Male" & (Orientation %in% c("Gay", "Other")), "MSM", "Non-MSM"),
    RiskCategory = categories[(MSM == "MSM") + (PWID == "PWID") - (PreP == "On PreP") + 2]
  ) -> patients

write_csv(patients, 'fakeinfectedpatients.csv')
