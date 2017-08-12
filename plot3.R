library(dplyr)
library(ggplot2)

nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

baltimore <- nei %>%
    filter(fips == 24510) %>%
    group_by(year, type) %>% 
    summarise(Emissions = sum(Emissions))

outFile = paste0(getwd(), "/plot3.png")
png(outFile, height=600, width=600)

qplot(year, Emissions, data=baltimore, facets = .~type, geom = c("point", "line"))

dev.off()