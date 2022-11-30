# Load the data
household_power <- read.csv("household_power_consumption.txt", sep = ";")

# Convert Date strings to Date object
household_power$Date <- as.Date(household_power$Date, format="%d/%m/%Y")

# Convert Global Active Power to numeric values
household_power$Global_active_power <- as.numeric(household_power$Global_active_power)

# Filter to data from 2007-02-01 and 2007-02-02
d <- rbind(subset(household_power, household_power$Date == as.Date("2007-02-01")),
           subset(household_power, household_power$Date == as.Date("2007-02-02")))

# Make the histogram plot with the filtered data
hist(d$Global_active_power, 
     main="Global Active Power", 
     col="red", 
     xlab="Global Active Power (kilowatts)", 
     breaks=24)

# Export plot to PNG
dev.copy(png, file="plot1.png")
dev.off()