#lines 3-28 are included in all 4 R scripts in order to load data set and properly subset/format
#it so that the code works, code will take more time to run because these lines are included
# assuming .txt file is in working directory
powerdata <- read.csv("household_power_consumption.txt", header = FALSE, stringsAsFactors = FALSE)

header <- strsplit(as.character(powerdata[1, 1]), split = ";")[[1]]

data_split <- strsplit(as.character(powerdata[[1]]), split = ";")

power_df <- as.data.frame(do.call(rbind, data_split), stringsAsFactors = FALSE)

power_df <- power_df[-1, ]

#creates data frame power_df
colnames(power_df) <- header

#convert Date column to date format keeping in mind .txt file format is day month year
power_df$Date <- as.Date(power_df$Date, format = "%d/%m/%Y")

#creates 'febdate' data frame for February 1st and 2nd 2007
febdate <- subset(power_df, Date %in% as.Date(c("2007-2-1", "2007-2-2")))

#confirm code actually isolated the feb 1st and 2nd 2007
head(febdate)

#script to to create plot 1 comparing global active power in kilowatts to frequency

#converts Global_active_power from character to numeric
febdate$Global_active_power<-as.numeric(febdate$Global_active_power)

# Plot 2 creation
png("plot2.png", height=480, width=480)

# Create the plot
plot(as.POSIXct(paste(febdate$Date, febdate$Time), format="%Y-%m-%d %H:%M:%S"),
     febdate$Global_active_power, type="l",
     ylab="Global Active Power (kilowatts)", xlab="",
     xaxt = "n")  # remove default tick labels

# Find the minimum datetime (for the first day) and increment by 1 day for the other two days
start_time <- min(as.POSIXct(paste(febdate$Date, febdate$Time), format="%Y-%m-%d %H:%M:%S"))  
thu_pos <- start_time
fri_pos <- thu_pos + 24 * 60 * 60 
sat_pos <- fri_pos + 24 * 60 * 60  

# Create the vector of positions for the x-axis ticks
tick_positions <- c(thu_pos, fri_pos, sat_pos)

# Customize x-axis labels to show only 3 points (Thu, Fri, Sat)
axis(1, at = tick_positions,             # Positions where we want the labels
     labels = c("Thu", "Fri", "Sat"))    # Labels corresponding to these positions

dev.off()
