library(dplyr)

nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

total <- nei %>%
    filter(fips == 24510) %>%
    group_by(year) %>% 
    summarise(Emissions = sum(Emissions))

outFile = paste0(getwd(), "/plot2.png")
png(outFile, height=600, width=600)

plot(total, pch=20, main="Total Emissions in Baltimore City, Maryland")
lines(total, lwd=3)

dev.off()
