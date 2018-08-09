library(dplyr)

n <- 1000

patients <- data.frame(
  id = 1:n,
  Gender = sample(c('Male', 'Female'), n, TRUE),
  Orientation = sample(c("Gay", "Striaght", "Bi", "Other"), n, TRUE),
  IDU = sample(c(TRUE,FALSE), n, TRUE),
  PreP = sample(c(TRUE,FALSE), n, TRUE)
)

patients %>%
  mutate(MSM = (Gender == "Male" & (Orientation %in% c("Gay", "Bi", "Other")))) -> patients

write.csv(patients, 'fakeinfectedpatients.csv', row.names = FALSE)
