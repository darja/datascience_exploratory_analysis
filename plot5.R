library(dplyr)

nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

vehicle_scc <- scc %>% 
    filter(str_detect(EI.Sector, "Vehicle")) %>%
    select(c(SCC, EI.Sector))

baltimore_vehicle_emissions <- nei %>%
    filter(fips == 24510 & SCC %in% vehicle_scc$SCC) %>%
    group_by(year) %>% 
    summarise(Emissions = sum(Emissions))

outFile = paste0(getwd(), "/plot5.png")
png(outFile, height=600, width=600)

plot(baltimore_vehicle_emissions, pch=20, main="Emissions From Motor Vehicle Sources in Baltimore City")
lines(baltimore_vehicle_emissions, lwd=3)

dev.off()