#load some packages
library(tidyverse)
library(magrittr)
library(ggplot2)
#load data sets
SCC <- readRDS("Source_Classification_Code.rds")
NEI <- readRDS("summarySCC_PM25.rds")
#now we will merge two datasets
fullData<-merge(NEI,SCC,by = "SCC")

#search for each coal in short.name variable
coal_matched<-grepl("coal", fullData$Short.Name, ignore.case=TRUE)
fullData_coal<-fullData[coal_matched,]
#calc count of Emission for each coal  by every year
TotalEmissions<- fullData_coal %>%
  group_by(year) %>%
  summarise(Emissions=sum(Emissions))

colrs<- c("red", "green", "blue", "yellow")
png("plot4.png")
plot4<-ggplot(TotalEmissions,aes(x=factor(year),y=Emissions,fill=colrs))+
  geom_bar(stat ="identity",show.legend = FALSE )+
  xlab("year")+
  ylab(expression('Total PM'[2.5]*" Emissions")) +
           ggtitle('Total Emissions from coal sources from 1999 to 2008')
print(plot4)
dev.off()
