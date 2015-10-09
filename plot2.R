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
png("plot2.png")

# graph 2
ylabel <- "Global Active Power (kilowatts)"
plot(x$TimeDate, x$Global_active_power, type="l", ylab=ylabel, xlab="")

# close canvas
dev.off()