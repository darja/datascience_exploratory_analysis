library(dplyr)

nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

coal_scc <- scc %>% 
    filter(str_detect(EI.Sector, "Coal")) %>%
    select(c(SCC, EI.Sector))

coal_emissions <- nei %>%
    filter(SCC %in% coal_scc$SCC) %>%
    group_by(year) %>% 
    summarise(Emissions = sum(Emissions))

outFile = paste0(getwd(), "/plot4.png")
png(outFile, height=600, width=600)

plot(coal_emissions, pch=20, main="Coal-Related Emissions")
lines(coal_emissions, lwd=3)

dev.off()