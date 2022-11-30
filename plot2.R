# Load the data
household_power <- read.csv("household_power_consumption.txt", sep = ";")

# Add DateTime field
household_power$DateTime <- paste(household_power$Date, household_power$Time)

# Convert Date strings to Date object
household_power$Date <- as.Date(household_power$Date, format="%d/%m/%Y")

# Convert Time strings to Time object
household_power$Time <- strptime(household_power$DateTime, 
                                 format="%d/%m/%Y %H:%M:%OS")

# Convert Global Active Power to numeric values
household_power$Global_active_power <- as.numeric(household_power$Global_active_power)

# Filter to data from 2007-02-01 and 2007-02-02
d <- rbind(subset(household_power, household_power$Date == as.Date("2007-02-01")),
           subset(household_power, household_power$Date == as.Date("2007-02-02")))

# Create the line graph
plot(d$Time, 
     d$Global_active_power, 
     type="l", 
     ylab="Global Active Power (kilowatts)", 
     xlab="")

# Export plot to PNG
dev.copy(png, file="plot2.png")
dev.off()
