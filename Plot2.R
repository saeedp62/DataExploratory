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

# plotting the Global Actvie Power vs. sysDate
# and setting the xlabel and ylable and color and type of the plot to be line
with(targetDB,plot(sysDate,Global_active_power, xlab = "", 
     ylab = "Global Active Power (kilowatts)", col = "black", type = "l"))



# Copy my plot to a PNG file called "Plot2.png"
dev.copy(png, "Plot2.png")

# Close the PNG device !
dev.off()