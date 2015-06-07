# Read data into a data frame
# Assumes that an unzipped copy of the data is present in the working directory
library(sqldf)
data <- read.csv.sql("household_power_consumption.txt",
                     header = TRUE,
                     sep = ";",
                     sql = "select * from file where Date in ('1/2/2007', '2/2/2007')")

# Set locale to make sure the names of weekdays are rendered in English
Sys.setlocale(category = "LC_ALL", locale = "en_US.UTF-8")

# Concatenate Date and Time columns, and convert them to a vector of POSIXlt date objects
timeline <- strptime(paste(data$Date, data$Time, sep = " "), format = "%d/%m/%Y %H:%M:%S")

# Open PNG device
png("plot4.png", width = 480, height = 480)
# Set graphics parameters to tile four plots
par(mfrow = c(2, 2))

# Plot graphs one by one, then close device to save the file
plot(timeline, data$Global_active_power,
     type = "l",
     col = "black",
     main = "",
     xlab = "",
     ylab = "Global Active Power")

plot(timeline, data$Voltage,
     type = "l",
     col = "black",
     main = "",
     xlab = "datetime",
     ylab = "Voltage")

plot(timeline, data$Sub_metering_1,
     type = "l",
     col = "black",
     main = "",
     xlab = "",
     ylab = "Energy sub metering")
lines(timeline, data$Sub_metering_2, type = "l", col = "red")
lines(timeline, data$Sub_metering_3, type = "l", col = "blue")
legend(x = "topright",
       box.lty = 0,
       legend = names(data[7:9]),
       lty = 1,
       col = c("black", "red", "blue"))

plot(timeline, data$Global_reactive_power,
     type = "l",
     col = "black",
     main = "",
     xlab = "datetime",
     ylab = "Global_reactive_power")

dev.off()