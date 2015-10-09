load_data <- function() {
    fname <- "household_power_consumption.txt"
    
    # check if file exists, if not download
    if (! file.exists(fname)) {
        url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(url, "data_set.zip", quiet = TRUE)
        unzip("data_set.zip")
    }
    
    
    data <- read.csv(fname, sep=";", na.strings="?")
    # filter for the specific dates
    data <- subset(data, Date == "1/2/2007" | Date == "2/2/2007")
    
    # convert the Time and Date columns
    convert_time <- function (date, time) {
        strptime(paste(date, time), "%d/%m/%Y %H:%M:%S")
    }
    data$TimeDate <- with(data, convert_time(Date, Time))
    
    return(data)
}

# read data
x<-load_data()

# open canvas
png("plot4.png")

# graph 4
par(mfrow=c(2,2))

# tile 1
ylabel <- "Global Active Power"
plot(x$TimeDate, x$Global_active_power, type="l", ylab=ylabel, xlab="")

# tile 2
ylabel <- "Voltage"
plot(x$TimeDate, x$Voltage, type="l", ylab=ylabel, xlab="datetime")

# tile 3
ylabel <- "Energy sub metering"
plot(x$TimeDate, x$Sub_metering_1, type="l", ylab=ylabel, xlab="")
lines(x$TimeDate, x$Sub_metering_2, col="red")
lines(x$TimeDate, x$Sub_metering_3, col="blue")
legend_text = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
legend_color = c("black", "red", "blue")
legend("topright", legend_text, lty=c(1,1),
       col=legend_color, cex=0.9, bty = "n")

# tile 4
ylabel <- "Global Reactive Power"
plot(x$TimeDate, x$Global_reactive_power, 
     type="l", ylab=ylabel, xlab="datetime")

# close canvas
dev.off()
