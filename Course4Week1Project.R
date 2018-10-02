## Week 4 Course 1
## Peer-graded Assignment: Course Project 1


#set working directory 
wd <- setwd("H:/Documents/DataSciences/ExData_Plotting1")
par(mfrow=c(1,1))
## Downloading data 
if(!file.exists("H:/Documents/DataSciences/ExData_Plotting1")){dir.create("H:/Documents/DataSciences/ExData_Plotting1/Dataset")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "H:/Documents/DataSciences/ExData_Plotting1/Dataset.zip")

## Unzipping data
unzip("H:/Documents/DataSciences/ExData_Plotting1/Dataset.zip", 
      exdir = wd) 

data <- read.table("household_power_consumption.txt",
                   header = T, sep = ";")

## date format 

##removing incomplete entries 
data <- data[complete.cases(data),]

data$Date <- as.Date(data$Date, "%d/%m/%Y")

## filtering dates 1 Feb 2007 to 2 Feb 2007

subset_data <- subset(data, Date >= as.Date("2007-02-01") & 
                          Date <= as.Date("2007-02-02"))

##removing incomplete entries 
subset_data <- subset_data[complete.cases(subset_data),]


## selecting numeric entries only

subset_data$Global_active_power <- as.numeric(subset_data$Global_active_power)
subset_data$Global_reactive_power <- as.numeric(subset_data$Global_reactive_power)
subset_data$Voltage <- as.numeric(subset_data$Voltage)
subset_data$Sub_metering_1 <- as.numeric(subset_data$Sub_metering_1)
subset_data$Sub_metering_2 <- as.numeric(subset_data$Sub_metering_2)
subset_data$Sub_metering_3 <- as.numeric(subset_data$Sub_metering_3)


##changing dates
subset_data <- transform(subset_data, newDate=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")

## Plot 1

hist(subset_data$Global_active_power, col = "red", main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")
dev.copy(png, file="plot1.png", width=480, height=480)
dev.off()

## Plot 2

plot(subset_data$newDate, subset_data$Global_active_power,
     type = "l", xlab ="", ylab = "GlobalActive Power (kilowatts)")
dev.copy(png, file="plot2.png", width=480, height=480)
dev.off()

## Plot 3

plot(subset_data$newDate, subset_data$Sub_metering_1, type = "l",
     ylab = "Energy sub metering", xlab = "")
lines(subset_data$newDate, subset_data$Sub_metering_2, type = "l", col = "red")
lines(subset_data$newDate, subset_data$Sub_metering_3, type = "l", col = "blue")
legend("topright" , c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = 1, lwd = 2.5, col = c("black", "red", "blue"))
dev.copy(png, file="plot3.png", width=480, height=480)
dev.off()


## Plot 4

par(mfrow=c(2,2))
plot(subset_data$newDate, subset_data$Global_active_power, type = "l", xlab = "",
     ylab = "Global Active Power")

plot(subset_data$newDate, subset_data$Voltage, type = "l", xlab = "datetime",
     ylab = "Voltage")

plot(subset_data$newDate, subset_data$Sub_metering_1, type = "l", xlab = "",
     ylab = "Energy sub metering")
lines(subset_data$newDate, subset_data$Sub_metering_2, type = "l", col = "red")
lines(subset_data$newDate, subset_data$Sub_metering_3, type = "l", col = "blue")
legend("topright" , c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = 1, lwd = 2.5, bty = "n", col = c("black", "red", "blue"))

plot(subset_data$newDate, subset_data$Global_reactive_power, type = "l", 
     ylab = "Global_reactive_power", xlab = "datetime")
dev.copy(png, file="plot4.png", width=480, height=480)
dev.off()