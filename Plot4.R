# # Assigning the URL of the dataset
URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
downloadFile <- "./household_power_consumption.zip"
householdFile <- "./household_power_consumption.txt"
### 
# Downloading and unzipping the file from the URL incase of non-existence
# into the working directory
if (!file.exists(householdFile)) {
  download.file(URL, downloadFile, method = "curl")
  unzip(downloadFile, overwrite = T)
}


# loading the required libraries
library(data.table)
library(dplyr)

# Reading the dataset by setting the seperator and NA values
DB <- read.table("./household_power_consumption.txt", header = TRUE, sep=";", na.strings="?"
                 , stringsAsFactors = FALSE)

# subsetting the required dates from "1/2/2007" till "2/2/2007"
targetDB <- filter(DB, Date == "1/2/2007" | Date == "2/2/2007")

#  convert the Date and Time variables to Date/Time classes
sysDate <- strptime(paste(targetDB$Date,targetDB$Time), "%d/%m/%Y %H:%M:%S")
# column binding the new dates and targetDB
targetDB <- cbind(sysDate,targetDB)

# deviding the active gaohic device into 2 rows and 2 coloumns
par(mfrow=c(2,2))

# plotting the Global Actvie Power vs. sysDate
with(targetDB,plot(sysDate,Global_active_power, xlab = "", 
                   ylab = "Global Active Power", col = "black", type = "l"))

# plotting the Voltage vs. sysDate
with(targetDB,plot(sysDate,Voltage, xlab = "datetime", 
                   ylab = "Voltage", col = "black", type = "l"))

#plotting the Energy sub metering vs. SysDate
# and setting the ylable and xlabe  
with(targetDB,plot(sysDate,Sub_metering_1, xlab = "", 
     ylab = "Energy Sub metering", type = "l", col = "black"))

# adding lines for different sub metering with proper color
with(targetDB,lines(sysDate,Sub_metering_2, col = "red",type = "l"))
with(targetDB,lines(sysDate,Sub_metering_3, col = "blue",type = "l"))
# adding legend to the plot
labels <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
legend("topright", legend=labels, col=c("black", "red", "blue"), lty="solid", bty="n")

# plotting the Voltage vs. sysDate
with(targetDB,plot(sysDate,Global_reactive_power, xlab = "datetime", 
                   ylab = "Global_reactive_power", col = "black", type = "l"))


# Copy my plot to a PNG file called "Plot2.png"
dev.copy(png, "Plot4.png")

# Close the PNG device !
dev.off()