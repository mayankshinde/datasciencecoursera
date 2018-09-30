#Downloading the Electrical Power Consumption Data
dir.create(tempfile())
temp = tempfile()
fileUrl = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,temp)
data = read.csv(unz(temp,"household_power_consumption.txt"), header = TRUE, sep = ";")
unlink(temp)

#Changing the class of Date column from "factor" to "Date"
data$Date = as.Date(data$Date, format = "%d/%m/%Y")

#Subsetting the data
data = data[(data$Date >= "2007-02-01" & data$Date <= "2007-02-02"),]

#Creating a new column "datetime" by merging Date and Time 
data$DateTime <- strptime(paste(data$Date, data$Time), format="%Y-%m-%d %H:%M:%S")

#Changing the class from "factor" to "numeric"
data$Global_active_power = as.numeric(as.character(data$Global_active_power))
data$Voltage = as.numeric(as.character(data$Voltage))
data$Sub_metering_1 = as.numeric(as.character(data$Sub_metering_1))
data$Sub_metering_2 = as.numeric(as.character(data$Sub_metering_2))
data$Sub_metering_3 = as.numeric(as.character(data$Sub_metering_3))
data$Global_reactive_power = as.numeric(as.character(data$Global_reactive_power))

#Open the PNG file device; create "plot1.png" in my working directory
png(filename = "plot4.png", width = 480, height = 480)

#Dividing the graphic device
par(mfrow=c(2,2))

#plot1
plot(data$DateTime,data$Global_active_power,type = "l", ylab = "Global Active Power", xlab = "")

#plot2
plot(data$DateTime,data$Voltage, type = "l", ylab = "Voltage", xlab = "datetime")

#plot3
plot(data$DateTime,data$Sub_metering_1, col = "black", type = "l", xlab = "", ylab = "Energy sub metering")
lines(data$DateTime,data$Sub_metering_2, col = "red")
lines(data$DateTime,data$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("black","red","blue"), lty  = c(1,1,1))

#plot4
plot(data$DateTime,data$Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime")

#Close the PNG device
dev.off()