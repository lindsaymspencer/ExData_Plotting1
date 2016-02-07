# Exploratory Data Analysis
# Course Project 1
# Plot 4
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

# Format times
mydata.sub$DateTime <-
    format(as.POSIXct(paste(mydata.sub$Date, mydata.sub$Time)),
           "%Y-%m-%d %H:%M:%S")
mydata.sub$DateTime <- strptime(mydata.sub$DateTime, "%Y-%m-%d %H:%M:%S")

# Change factors to integers, so the data displays correctly
# http://stackoverflow.com/questions/3418128/how-to-convert-a-factor-to-an-integer-numeric-without-a-loss-of-information
as.numeric.factor <- function(x) {as.numeric(levels(x))[x]}
mydata.sub$Global_active_power <-
    as.numeric.factor(mydata.sub$Global_active_power)
mydata.sub$Global_reactive_power <-
    as.numeric.factor(mydata.sub$Global_reactive_power)
mydata.sub$Voltage <- as.numeric.factor(mydata.sub$Voltage)
mydata.sub$Sub_metering_1 <- as.numeric.factor(mydata.sub$Sub_metering_1)
mydata.sub$Sub_metering_2 <- as.numeric.factor(mydata.sub$Sub_metering_2)
mydata.sub$Sub_metering_3 <- as.numeric.factor(mydata.sub$Sub_metering_3)

# Create the graph
png("plot4.png", width = 480, height = 480, res = 100)
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
plot(mydata.sub$DateTime, mydata.sub$Global_active_power, type="l",
     ylab = "Global Active Power", xlab = "", cex.axis=0.7, cex.lab=0.7)
plot(mydata.sub$DateTime, mydata.sub$Voltage, type="l",
     ylab = "Voltage", xlab = "datetime", cex.axis=0.7, cex.lab=0.7)
plot(mydata.sub$DateTime, mydata.sub$Sub_metering_1,type="l",
     xlab="", ylab="Energy sub metering", cex.axis=0.7, cex.lab=0.7)
lines(mydata.sub$DateTime, mydata.sub$Sub_metering_2, type="l", col="red")
lines(mydata.sub$DateTime, mydata.sub$Sub_metering_3, type="l", col="blue")
legend("topright",  col = c("black", "blue", "red"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=c(1, 1, 1), cex=.70, bty='n')
plot(mydata.sub$DateTime, mydata.sub$Global_reactive_power, type="l",
     ylab = "Global_reactive_power", xlab = "datetime", cex.axis=0.7,
     cex.lab=0.7)

# Close the device
dev.off()