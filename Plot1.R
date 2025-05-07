install.packages(c("data.table"))
library(data.table)

### Data Loading ####
# Read data, subsetting for 2007-02-01 and 2007-02-02
data <- fread("household_power_consumption.txt", sep = ";", na.strings = "?", 
              select = c("Date", "Time", "Global_active_power", "Global_reactive_power", 
                         "Voltage", "Global_intensity", "Sub_metering_1", 
                         "Sub_metering_2", "Sub_metering_3"))[Date %in% c("1/2/2007", "2/2/2007")]

# Combine Date and Time into a single POSIXct column
data$Datetime <- as.POSIXct(strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S"))

# Convert columns to numeric if needed
data$Global_active_power <- as.numeric(data$Global_active_power)
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)
data$Voltage <- as.numeric(data$Voltage)
data$Global_reactive_power <- as.numeric(data$Global_reactive_power)

#### plot1.R ####
# Load data
data <- read.csv("household_power_consumption.txt", sep = ";", na.strings = "?", 
                 stringsAsFactors = FALSE)
data <- data[data$Date %in% c("1/2/2007", "2/2/2007"), ]

# Convert Global_active_power to numeric
data$Global_active_power <- as.numeric(data$Global_active_power)

# Create PNG plot
png("plot1.png", width = 480, height = 480)
hist(data$Global_active_power, col = "red", 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", 
     ylab = "Frequency")
dev.off()
