# Exploratory data analysis - Week 1
# Code for downloading dataset and creating graph as per Peer-graded Assignment: Course Project 1
# Plot 4

# Download file
url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destfile<-"./power_consumption.zip"
download.file(url=url, destfile = destfile)
# Unzip file
unzip("./power_consumption.zip")
# Read into R with the read.table function
data <- read.table("./household_power_consumption.txt",sep = ";", header = TRUE, dec = ".", na.strings = "?")
# Subset the table with the two days as per assignment
pwr_cons<-subset(data, data$Date=="1/2/2007" | data$Date=="2/2/2007")
# Remove the initial file, read into R, in order to free memory
rm(data)

# Convert date and time into useable format (create two new columns for that purpose - new_date and new_time)
pwr_cons$new_date <- strptime(as.character(pwr_cons$Date), "%d/%m/%Y")
pwr_cons$Date <- format(pwr_cons$new_date, "%Y-%m-%d")
pwr_cons$new_time <- as.POSIXct(paste(pwr_cons$Date, pwr_cons$Time), format="%Y-%m-%d %H:%M:%S")

# Plot 4

png(file="plot4.png", height = 480, width = 480)
par(mfrow=c(2,2))


#global active power plot (same as plot 2)
plot(pwr_cons$new_time, pwr_cons$Global_active_power,xlab = "", ylab = "Global Active Power", type = "l")


# voltage plot
plot(pwr_cons$new_time, pwr_cons$Voltage ,xlab = "datetime", ylab = "Voltage", type = "l")


# energy sub metering (same as plot 3)
plot(pwr_cons$new_time, pwr_cons$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(pwr_cons$new_time, pwr_cons$Sub_metering_2, type = "l", col = "red")
lines(pwr_cons$new_time, pwr_cons$Sub_metering_3, type = "l", col = 'blue')
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1, bty = "n")


# global reactive power slot
plot(pwr_cons$new_time, pwr_cons$Global_reactive_power ,xlab = "datetime", ylab = "Global_reactive_power", type = "l")

dev.off()
