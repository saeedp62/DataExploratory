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

targetDB$Date <- as.Date(targetDB$Date, "%d/%m/%Y")

# plotting the histogram of Global Actvie Power
# and setting the title and xlable and color 
hist(targetDB$Global_active_power, xlab = "Global Active Power (kilowatts)", 
     main = "Global Active Power", col = "red")

# Copy my plot to a PNG file called "Plot1.png"
dev.copy(png, "Plot1.png")

# Close the PNG device !
dev.off()