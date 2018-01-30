
#download file into R console
epc <- read.csv("household_power_consumption.txt", sep = ";", header = TRUE, stringsAsFactors = FALSE)

#convert dates into proper format
epc$Date <- as.Date(epc$Date, format = "%d/%m/%Y")

#only use dates between 2007-02-01 and 2007-02-02
epc1 <- subset(epc, Date == "2007-02-01" | Date =="2007-02-02")

#convert power used to number from character
epc1[,3:9] <- lapply(epc1[,3:9], as.numeric)


#create png file
png(file = "plot1.png", width = 480, height = 480)

#create histogram
hist(epc1$Global_active_power,
     col = "red",
     ylim = c(0,1200),
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)"
)
dev.off()
