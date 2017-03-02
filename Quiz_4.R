
Q1
Apply strsplit() to split all the names of the data frame on the characters "wgtp". 
What is the value of the 123 element of the resulting list?

A1
q1 <- read.csv("Quiz4Q1.csv")
strsplit(names(q1), "wgtp") [123]


Q2
Remove the commas from the GDP numbers in millions of dollars and average them. What is the average?

A2
q2 <- read.csv("Quiz4Q2.csv", skip = 5, nrows = 190, stringsAsFactors = F, header = F)
q2 <- q2[, c(1, 2, 4, 5)]
colnames(q2) <- c("CountryCode", "Rank", "Country.Name", "GDP.Value")
q2$GDP.Value <- as.numeric(gsub(",", "", q2$GDP.Value))

mean(q2$GDP.Value)


Q3
In the data set from Question 2 what is a regular expression that would allow you to count the number of countries whose name begins with "United"? 
Assume that the variable with the country names in it is named countryNames. How many countries begin with United?

A3
grep("^United",q2$Country.Name)


Q4
Match the data based on the country shortcode. 
Of the countries for which the end of the fiscal year is available, how many end in June?

A4



Q5
How many values were collected in 2012? How many values were collected on Mondays in 2012?

A5
install.packages("quantmod")

library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)

library(lubridate)

sum(year(sampleTimes) == "2012")
sum(wday(sampleTimes) == "2" & year(sampleTimes) == "2012")
