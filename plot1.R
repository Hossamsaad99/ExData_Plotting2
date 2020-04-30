#load some packages
library(tidyverse)
library(magrittr)
#load data sets
SCC <- readRDS("Source_Classification_Code.rds")
NEI <- readRDS("summarySCC_PM25.rds")

#calc count of Emission by every year
TotalEmission<- NEI %>%
  group_by(year) %>%
  summarise(Emissions=sum(Emissions))

# plot by barplot to see if Emission decrease  in the United States from 1999 to 2008? 
colrs<- c("red", "green", "blue", "yellow")
png('plot1.png')
barplot(height = TotalEmission$Emissions,names.arg = TotalEmission$year,
        ylab = expression('total PM'[2.5]*' emission'), xlab = "Year",
        main = expression('Total PM'[2.5]*' emissions every years'),col = colrs)
dev.off()

#after plotting , we notes Emission decrease from 1999 to 2008
