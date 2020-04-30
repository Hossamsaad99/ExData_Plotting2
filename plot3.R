#load some packages
library(tidyverse)
library(magrittr)
library(ggplot2)
#load data sets
SCC <- readRDS("Source_Classification_Code.rds")
NEI <- readRDS("summarySCC_PM25.rds")

#subset data to filter it for  (fips=="24510") 
NEIsubset<-NEI %>%
  filter(fips=="24510")
#calc count of Emission in Baltimore  City by every year and by each type
TotalEmission_Baltimore_type<- NEIsubset %>%
  group_by(year,type) %>%
  summarise(Emissions=sum(Emissions)) %>%
  arrange(desc(Emissions))

#plot by bar plot to see  Which have seen increases in emissions from 1999 2008 for each type
png("plot3.png")
plot3<- ggplot(TotalEmission_Baltimore_type,aes(x=factor(year),y=Emissions,fill=type,label=round(Emissions,2)))+
  geom_bar(stat="identity")+
  facet_grid(.~type)+
  xlab("Years")+
  ylab(expression("total PM"[2.5]*" emission in tons")) +
  ggtitle(expression("PM"[2.5]*paste(" emissions in Baltimore ",
                                     "City by each types", sep="")))
print(plot3)
dev.off()
