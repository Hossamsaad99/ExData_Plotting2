#load some packages
library(tidyverse)
library(magrittr)
#load data sets
SCC <- readRDS("Source_Classification_Code.rds")
NEI <- readRDS("summarySCC_PM25.rds")

fullData<-merge(NEI,SCC,by = "SCC")

fullData_filtered_two<- fullData %>%
  filter(fips=="24510"|fips=="06037" , type=="ON-ROAD")

TotalEmission_Bal_LosAng_vehicle<- fullData_filtered_two %>%
  group_by(fips,year) %>%
  summarise(Emissions=sum(Emissions))
TotalEmission_Bal_LosAng_vehicle$fips[TotalEmission_Bal_LosAng_vehicle$fips=="24510"] <- "Baltimore, MD"
TotalEmission_Bal_LosAng_vehicle$fips[TotalEmission_Bal_LosAng_vehicle$fips=="06037"] <- "Los Angeles, CA"


png("plot6.png")
plot6 <- ggplot(TotalEmission_Bal_LosAng_vehicle, aes(x=factor(year),y= Emissions))+
  facet_grid(. ~ fips)+
  geom_bar(stat="identity")  +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions from motor vehicle (type=ON-ROAD) in Baltimore City, MD (fips = "24510") vs Los Angeles, CA (fips = "06037")  1999-2008')
print(plot6)
dev.off()