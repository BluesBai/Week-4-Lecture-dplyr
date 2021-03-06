#uncomment the below line if you have not already installed tidyverse
#install.packages("tidyverse")
library(tidyverse)
# if you get an error with loading tidyverse load the packages individually by uncommenting the next lines
#library(ggplot2)
#library(tibble)
#library(tidyr)
#library(readr)
#library(purrr)
#library(dplyr)
bnames <- read.csv("bnames.csv", stringsAsFactors = F)
str(bnames)
summary(bnames)
#Q1 Find all of the names that are in the same soundex as your name (or your favorite name, in case you don't have a common English name).
vivian <- filter(bnames, name == "Vivian") 
vivian$soundex[1]
#Q2 Select the rows of all girls born in 1900 or 2000.
filter(bnames, sex=="girl"&(year==1900|year==2000)
#Q3 How many times did a name reach a proportion greater than 0.01 after the year 2000?
nrow(filter(bnames, year > 2000 & prop > 0.01))
#Q4.From bnames, select the columns whose names start with, ‘y’, ‘s’, or ‘p’.
select(bnames, starts_with('y'), starts_with('s'), starts_with('p'))
#Q5. Create a data frame  that is the same as bnames without the column “year”.
select(bnames, -starts_with('y')) 	# either can be used
select(bnames, -year) 			# in this case
#Q6. Select the columns “year” and “name”from bnames. Use only one condition to achieve this.
select(bnames, contains('a'))
#Q7. Reorder the dataset bnames by prop in descending order.
arrange(bnames, desc(prop))
#Q8. In what year was your name the most popular?
filter(arrange(bnames, desc(prop)), name=='Vivian')[1,]
#Q9 For the data frame bnames, create a column "percentage", which derives from "prop" by changing the proportion to a percentage.
mutate(bnames, percentage=100*prop)
#Q10. Create a summary that displays the min, mean, and max prop for your name, from the data frame bnames.
summarise(filter(bnames, name=='Vivian'), min(prop), mean(prop), max(prop), na.rm=T)
#Q11. Create a data frame bnames2 with the code below, replacing “your_join” by the join function you decide to use. Notice that the parameter specifies a vector. How do you think this works?
#bnames2 = your_join(bnames, births, by=c("year","sex"))  
bnames2 = inner_join(bnames, births,  by = c("year","sex"))   
#Is this correct?
births <- read.csv(“births.csv”,stringsAsFactors = F)  
bnames2 = inner_join(bnames, births,  by = c("year","sex"))
summary(bnames2)       
#Q12. Add a new column  to bnames2 whose value is the desired number.  Name the column “n”.
bnames2 = mutate(bnames2, n = round(prop * births)) 
#round() makes sure we have an integer. It does not make sense to have 1.5 babies.
#Q13. Recover the births data frame from bnames2 with group_by() and summarize(). Call it birth2. 
summarise(group_by(bnames2, year, sex), births=first(births))
# Since within a year, the number of boys/girls born is independent of their name. We can just pick the first one.
#Q14. If the result you obtain is not exactly the same as the original births data frame, what do you think caused the difference?
df = data.frame(color = c("blue","black", "blue", "blue","black"),value = 1:5)
#Q16. Reproduce the result of sum of values for each color. Use the %>% operator this time.
df %>% group_by(color) %>% summarise(total=sum(value))
       
#Practice Exercises

#1.Install the package nycflights13

#2.Install the package tidyverse

#3.Load the data frame flights

#4.Find all flights on February 11

#5.Find all flights departing Houston (HOU) that had an departure delay of more than 2 hours

#6.Arrange flights in descending order of Arrival Delays









