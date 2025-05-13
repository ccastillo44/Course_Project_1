library(data.table)

### Data Loading ####
data <- read.csv("household_power_consumption.txt", sep = ";", na.strings = "?", 
                 stringsAsFactors = FALSE)
data <- data[data$Date %in% c("1/2/2007", "2/2/2007"), ]

# Crear columna Datetime
data$Datetime <- as.POSIXct(strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S"))

# Convertir variables a numéricas
data$Global_active_power <- as.numeric(data$Global_active_power)
data$Global_reactive_power <- as.numeric(data$Global_reactive_power)
data$Voltage <- as.numeric(data$Voltage)
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)

# Crear PNG con 4 gráficos
png("plot4.png", width = 480, height = 480)

# Cuadrícula 2x2
par(mfrow = c(2, 2))

# Gráfico 1: Global Active Power
plot(data$Datetime, data$Global_active_power, type = "l", 
     xlab = "", ylab = "Global Active Power")

# Gráfico 2: Voltage
plot(data$Datetime, data$Voltage, type = "l", 
     xlab = "datetime", ylab = "Voltage")

# Gráfico 3: Sub-metering
plot(data$Datetime, data$Sub_metering_1, type = "l", col = "black",
     xlab = "", ylab = "Energy sub metering")
lines(data$Datetime, data$Sub_metering_2, col = "red")
lines(data$Datetime, data$Sub_metering_3, col = "blue")
legend("topright", bty = "n", lty = 1, col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Gráfico 4: Global Reactive Power
plot(data$Datetime, data$Global_reactive_power, type = "l", 
     xlab = "datetime", ylab = "Global_reactive_power")

# Cerrar PNG
dev.off()

