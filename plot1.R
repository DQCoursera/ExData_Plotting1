#lines 3-29 are included in all 4 R scripts in order to load data set and properly subset/format
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

#saving as a png with proper title and dimensions
png("plot1.png", width =480, height=480)

#histogram creation with title and X axis labeled
with(febdate, hist(Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red"))

#closes device and saves graph
dev.off()
