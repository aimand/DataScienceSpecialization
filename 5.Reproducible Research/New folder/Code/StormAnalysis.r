StormAnalysis <- function() {
	# Get Library
	require(ggplot2)
	
	#setwd("C:/Users/Aiman/Box Sync/NSU/DataScience/5.Reproducible Research/Week3/Code/")
	
	stormData <- read.csv("C:/Users/Aiman/Box Sync/NSU/DataScience/5.Reproducible Research/Week3/Data/repdata_data_StormData.csv", sep = ",")
	#str(stormData)
	
	subStorm <- stormData [,c("STATE", "EVTYPE", "FATALITIES", "INJURIES", "PROPDMG", "PROPDMGEXP","CROPDMG", "CROPDMGEXP")]
	sum (is.na (subStorm))
	# Deaths
	deathData <- aggregate (FATALITIES~EVTYPE, subStorm, sum)
	deathData <- deathData [order(deathData$FATALITIES, decreasing=TRUE),]
	
	png(filename = "../Plots/Deaths.png")
	barplot (height = deathData$FATALITIES[1:30], names.arg = deathData$EVTYPE[1:30], las = 2, cex.names= 0.8,
         col = rainbow (30, start=0, end=0.5))
	title (main = "Deaths Per Event", line=-5)
	title (ylab = "Total Number of Deaths", line=4)

	
	
	#Injuries
	injurData <- aggregate (INJURIES~EVTYPE, stormData, sum)
	injurData <- injurData [order(injurData$INJURIES, decreasing=TRUE),]

	png(filename = "../Plots/Injuries.png")
	barplot (height = injurData$INJURIES[1:30], names.arg = injurData$EVTYPE[1:30], las = 2, cex.names = 0.8,
         col = rainbow (30, start=0, end=0.5))
	title (main = "Injuries Per Event", line=-5)
	title (ylab = "Total Number of Injuries", line=4)
	
	
	#Damage
	symbol <- c("", "+", "-", "?", 0:9, "h", "H", "k", "K", "m", "M", "b", "B");
	factor <- c(rep(0,4), 0:9, 2, 2, 3, 3, 6, 6, 9, 9)
	multiplier <- data.frame (symbol, factor)

	subStorm$damage.prop <- subStorm$PROPDMG*10^multiplier[match(subStorm$PROPDMGEXP,multiplier$symbol),2]
	subStorm$damage.crop <- subStorm$CROPDMG*10^multiplier[match(subStorm$CROPDMGEXP,multiplier$symbol),2]
	subStorm$damage <- subStorm$damage.prop + subStorm$damage.crop

	damage <- aggregate (damage~EVTYPE, subStorm, sum);
	damage$bilion <- damage$damage / 1e9;
	damage <- damage [order(damage$bilion, decreasing=TRUE),]

	png(filename = "../Plots/Damages.png")
	barplot (height = damage$bilion[1:30], names.arg = damage$EVTYPE[1:30], las = 2, cex.names = 0.8,
         col = rainbow (30, start=0, end=0.5))
	title ("Damages Per Event", line=-5)
	title (ylab = "Total Damage In Bilion of US$")
	
	
	dev.off()	
	
}
