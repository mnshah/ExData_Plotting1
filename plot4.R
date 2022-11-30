# Load the data
household_power <- read.csv("household_power_consumption.txt", sep = ";")

# Add DateTime field
household_power$DateTime <- paste(household_power$Date, household_power$Time)

# Convert Date strings to Date object
household_power$Date <- as.Date(household_power$Date, format="%d/%m/%Y")

# Convert Time strings to Time object
household_power$Time <- strptime(household_power$DateTime, 
                                 format="%d/%m/%Y %H:%M:%OS")

# Convert Sub Metering strings to numeric values
household_power$Sub_metering_1 <- as.numeric(household_power$Sub_metering_1)
household_power$Sub_metering_2 <- as.numeric(household_power$Sub_metering_2)
household_power$Sub_metering_3 <- as.numeric(household_power$Sub_metering_3)

# Convert Global Active Power strings to numeric values
household_power$Global_active_power <- as.numeric(household_power$Global_active_power)

# Convert Global Active Power strings to numeric values
household_power$Global_reactive_power <- as.numeric(household_power$Global_reactive_power)


# Convert Voltage strings to numeric values
household_power$Voltage <- as.numeric(household_power$Voltage)

# Filter to data from 2007-02-01 and 2007-02-02
d <- rbind(subset(household_power, household_power$Date == as.Date("2007-02-01")),
           subset(household_power, household_power$Date == as.Date("2007-02-02")))

# Create the grid for the plots
par(mfrow=c(2, 2))

# Create plot #1: Global Active Power by Day
plot(d$Time, 
     d$Global_active_power, 
     type="l", 
     ylab="Global Active Power (kilowatts)", 
     xlab="")

# Create plot #2: Voltage by Day
plot(d$Time, 
     d$Voltage, 
     type="l", 
     ylab="Voltage", 
     xlab="datetime",
     yaxt="none")
axis(2, seq(234, 246, 4))

# Create plot #3: Energy sub metering by Day
plot(d$Time, d$Sub_metering_1, type="n", ylab="Energy sub metering", xlab="")

# Add the lines to the plot
lines(d$Time, d$Sub_metering_1)
lines(d$Time, d$Sub_metering_2, col="red")
lines(d$Time, d$Sub_metering_3, col="blue")

# Add the legend to the plot
legend("topright", 
       legend=c("Sub_metering1", "Sub_metering2", "Sub_metering3"), 
       col=c("black", "red", "blue"), 
       lty=1,
       bty="n")

# Create plot #4: Global Reactive Power by Daytime
plot(d$Time, 
     d$Global_reactive_power, 
     type="l", 
     ylab="Global_reactive_power", 
     xlab="datetime")

# Export plot to PNG
dev.copy(png, file="plot4.png")
dev.off()
