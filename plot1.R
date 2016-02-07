# Exploratory Data Analysis
# Course Project 1
# Plot 1
# Lindsay Spencer
# 6 FEB 2016

# Read in data from working directory
mydata = read.csv("household_power_consumption.txt", sep=";", na.strings="?")

# Change dates to date type
mydata$Date <- as.Date(mydata$Date, "%d/%m/%Y")

# Subset data from Feb 1 & 2, 2007
mydata.sub <- subset(mydata, Date == as.Date("2007-02-01") |
                         Date == as.Date("2007-02-02"))

# Clean up a bit
rm("mydata")

# Change factors to integers, so the data displays correctly
# http://stackoverflow.com/questions/3418128/how-to-convert-a-factor-to-an-integer-numeric-without-a-loss-of-information
as.numeric.factor <- function(x) {as.numeric(levels(x))[x]}
mydata.sub$Global_active_power <-
    as.numeric.factor(mydata.sub$Global_active_power)

# Create the histogram
png("plot1.png", width = 480, height = 480, res = 100)
hist(mydata.sub$Global_active_power, col = "red",
     xlab = "Global Active Power (kilowatts)", main = "Global Active Power",
     ylim=c(0,1300), cex.axis=0.7, cex.lab=0.7)

# Close the device
dev.off()
