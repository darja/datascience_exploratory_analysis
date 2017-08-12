library(dplyr)
library(ggplot2)

nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

vehicle_scc <- scc %>% 
    filter(str_detect(EI.Sector, "Vehicle")) %>%
    select(c(SCC, EI.Sector))

locations = data.frame(fips = c("24510", "06037"), name = c("Baltimore City", "Los Angeles County"), stringsAsFactors = FALSE)

vehicle_emissions <- nei %>%
    filter(fips %in% locations$fips & SCC %in% vehicle_scc$SCC) %>%
    group_by(year, fips) %>% 
    summarise(Emissions = sum(Emissions)) %>%
    full_join(locations, by = c("fips" = "fips"))

qplot(year, Emissions, data=vehicle_emissions, facets = .~name, geom = c("point", "line"))