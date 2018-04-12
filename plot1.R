# Exploratory data analysis - Week 1
# Code for downloading dataset and creating graph as per Peer-graded Assignment: Course Project 1
# Plot 1


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


# Plot 1
png(file="plot1.png", height = 480, width = 480)
hist(pwr_cons$Global_active_power, col='red', main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency")
dev.off()

