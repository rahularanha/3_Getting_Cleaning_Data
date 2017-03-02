
Que 1

The American Community Survey distributes downloadable data about United States communities. Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here:

https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv

and load the data into R. The code book, describing the variable names is here:

https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf

Create a logical vector that identifies the households on greater than 10 acres who sold more than $10,000 worth of agriculture products. Assign that logical vector to the variable agricultureLogical. Apply the which() function like this to identify the rows of the data frame where the logical vector is TRUE.

which(agricultureLogical)

What are the first 3 values that result?

Ans 1

added <- mutate(q1, agricultureLogical = ( ACR == 3 & AGS == 6 ))
which(added$agricultureLogical)[1:3]


Que 2

Using the jpeg package read in the following picture of your instructor into R

https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg

Use the parameter native=TRUE. What are the 30th and 80th quantiles of the resulting data? (some Linux systems may produce an answer 638 different for the 30th quantile)

Ans 2

q2 <- readJPEG("Quiz3Q2.jpg", native = TRUE)

quantile(q2, probs = c(0.3, 0.8))
      30%       80% 
-15259150 -10575416


Que 3

Load the Gross Domestic Product data for the 190 ranked countries in this data set:

https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv

Load the educational data from this data set:

https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv

Match the data based on the country shortcode. How many of the IDs match? Sort the data frame in descending order by GDP rank (so United States is last). What is the 13th country in the resulting data frame?

Original data sources:

http://data.worldbank.org/data-catalog/GDP-ranking-table

http://data.worldbank.org/data-catalog/ed-stats

Ans 3

q3a <- read.csv("Quiz3Q3a.csv", skip = 5, nrows = 190, stringsAsFactors = F, header = F)
q3b <- read.csv("Quiz3Q3b.csv", stringsAsFactors = F)

q3a <- q3a[, c(1, 2, 4, 5)]                                                   ##extracting required cols
colnames(q3a) <- c("CountryCode", "Rank", "Country.Name", "GDP.Value")
q3a$GDP.Value <- as.numeric(gsub(",", "", q3a$GDP.Value))             ##converting GDP values into numeric

matchedData <- merge(q3a, q3b, by.x = "CountryCode", by.y = "CountryCode")
dim(matchedData)[1]                                                           ## Number of matched countries

sorted <- arrange(matchedData, GDP.Value)
sorted[13, 3]


Que 4

What is the average GDP ranking for the "High income: OECD" and "High income: nonOECD" group?

Ans 4

matchedData %>% group_by(Income.Group) %>% summarise(mean(Rank))


Que 5

Cut the GDP ranking into 5 separate quantile groups. Make a table versus Income.Group. 
How many countries are Lower middle income but among the 38 nations with highest GDP?

Ans 5

quantile(sorted$Rank, probs = c(0.2, 0.4, 0.6, 0.8, 1), na.rm = TRUE)

sorted2<- arrange(matchedData,Rank)[1:38,]
sorted2 %>% group_by(Income.Group) %>% summarize(n())
