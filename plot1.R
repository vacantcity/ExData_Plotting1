# Read data into a data frame
# Assumes that an unzipped copy of the data is present in the working directory
library(sqldf)
data <- read.csv.sql("household_power_consumption.txt",
                     header = TRUE,
                     sep = ";",
                     sql = "select * from file where Date in ('1/2/2007', '2/2/2007')")

# Open PNG device, plot histogram and close device to save the file
png("plot1.png", width = 480, height = 480)
hist(data$Global_active_power,
     col = "red",
     xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power")
dev.off()

closeAllConnections()