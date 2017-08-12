nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

total <- nei %>% 
    group_by(year) %>% 
    summarise(Emissions = sum(Emissions))

plot(total, pch=20, main="Total Emissions")
lines(total, lwd=3)