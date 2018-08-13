library(dplyr)
library(readr)

n <- 1000

ages <- rnorm(n)

patients <- tibble(
  `Age at Diagnosis` = sample(c('13-19', '20-29', '30-39', '40-49', '50-59', '60+'), n, TRUE, c(1675, 14740, 9943, 6490, 4882, 1930)),
  `Sex at Birth` = sample(c('Male', 'Female', 'Intersex'), n, TRUE, prob = c(.49, .5, .01)),
  `Sexual Orientation` = sample(c("Straight", "Gay", "Bi"), n, TRUE, prob = c(.23, .68, .09)),
  Race = sample(c("Caucasian (Non-Hispanic/Latinx)", "Hispanic/Latinx", "African-American", "Native American", "Asian-American", "Other"), n, TRUE, c(.1, .25, .44, .1, .01, .1)),
  Region = sample(c('South', 'Northeast', 'West', 'Midwest'), n, TRUE, c(16.8, 11.2, 10.2, 7.5)),
  PWID = sample(c("PWID", "Non-PWID"), n, TRUE, c(.09, .91)),
  `Viral Supression` = sample(c("Supressed", "Not Supressed"), n, TRUE, c(.49, .51))
)

categories <- c('1 Low', '2 Medium', '3 High', '4 Very High')

identified_gender <- function(sab){
  if(sab == 'Male'){
    if(runif(1) < 0.017){
      return('Trans Woman')
    }
    return('Cis Man')
  }
  if(sab == 'Female'){
    if(runif(1) < 0.003){
      return('Trans Man')
    }
    return('Cis Woman')
  }
  return(sab)
}

vig <- Vectorize(identified_gender)

patients %>%
  mutate(
    Gender = vig(`Sex at Birth`),
    MSM = ifelse(`Sex at Birth` == "Male" & (`Sexual Orientation` %in% c("Gay", "Bi")), "MSM", "Non-MSM"),
    `Transmission Category` = ifelse(MSM == 'MSM', 'MSM', ifelse(PWID == 'PWID', 'PWID', ifelse(`Sexual Orientation` == 'Straight', 'HET', 'Other'))),
    RiskCategory = categories[(MSM == "MSM") + (PWID == "PWID") + (`Viral Supression` == "Not Supressed") + 1]
  ) -> patients

write_csv(patients, 'fakeinfectedpatients.csv')
