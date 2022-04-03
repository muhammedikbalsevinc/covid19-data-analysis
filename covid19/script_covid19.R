library(Hmisc)

nrow(data)  # finding size of dataset
ncol(data)

col_list <- names(data) # what all columns are there
col_list

str(data) # structure of dataframe

length(data)  # length of dataframe

summary(data) # summary of dataframe

# cleaned up death column
data$death_dummy <- as.integer(data$death != 0)

# cleaned up recovered column
data$recovered_dummy <- as.integer(data$recovered != 0)

# death rate
sum(data$death_dummy) / nrow(data)

# age
# claim: older people have more risk of dying
dead = subset(data, death_dummy ==1)
alive = subset(data, death_dummy ==0)
mean(dead$age, na.rm = TRUE) #68
mean(alive$age, na.rm = TRUE) #48
# t-test
t.test(alive$age, dead$age, alternative="two.sided", conf.level = 0.95)
# p-value ~ 0, so we reject the null hyppothesis and 
# it means that this is statistically significant

# gender
# claim: there is no relevance between gender and die rate
men = subset(data, gender == "male")
women = subset(data, gender == "female")
mean(men$death_dummy, na.rm = TRUE) #8.5%
mean(women$death_dummy, na.rm = TRUE) #3.7%
# t-test
t.test(men$death_dummy, women$death_dummy, alternative="two.sided", conf.level=0.95)
# 99% confidence: men have 4.8% higher chance of dying, so claim is wrong.
# p-value = 0.002 < 0.05, it means that this is statistically significant
