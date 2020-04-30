#load some packages
library(tidyverse)
library(magrittr)
#load data sets
SCC <- readRDS("Source_Classification_Code.rds")
NEI <- readRDS("summarySCC_PM25.rds")

#subset data to filter it for  (fips=="24510")
NEI_subset<-NEI %>%
  filter(fips=="24510")
#calc count of Emission in Baltimore City by every year
TotalEmission_Baltimore<- NEI_subset %>%
  group_by(year) %>%
  summarise(Emissions=sum(Emissions))

#plot by barplot to see if Emission decrease  in Baltimore City from 1999 to 2008? 
colrs<- c("red", "green", "blue", "yellow")
png('plot2.png')
barplot(height = TotalEmission_Baltimore$Emissions,
        names.arg = TotalEmission_Baltimore$year,
        ylab = expression('total PM'[2.5]*' emission'), xlab = "Year",
        main = expression('Total PM'[2.5]*'in the Baltimore City, emissions every years'),col = colrs)
dev.off()