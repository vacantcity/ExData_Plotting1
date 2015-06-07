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

# Open PNG device, plot graph and close device to save the file
png("plot2.png", width = 480, height = 480)
plot(timeline, data$Global_active_power,
     type = "l",
     main = "",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")
dev.off()

closeAllConnections()