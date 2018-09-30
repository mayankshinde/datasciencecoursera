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

#Open the PNG file device; create "plot1.png" in my working directory
png(filename = "plot2.png", width = 480, height = 480)

#Constructing the scatterplot
plot(data$DateTime,data$Global_active_power, type="l", ylab = "Global Active Power (kilowatts)", xlab = "")

#Close the PNG device
dev.off()