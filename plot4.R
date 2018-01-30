library(dplyr)

#download file into R console
epc <- read.csv("household_power_consumption.txt", sep = ";", header = TRUE, stringsAsFactors = FALSE)

#only use dates between 2007-02-01 and 2007-02-02
epc1 <- subset(epc, Date == "1/2/2007" | Date =="2/2/2007")

#add combined date and time column in string form
epc1 <- mutate(epc1, date_time = paste(Date, Time, sep =" "))

#convert to time from string
epc1$date_time <- strptime(epc1$date_time, "%d/%m/%Y %H:%M:%S")

#convert power used to number from character
epc1[,3:9] <- lapply(epc1[,3:9], as.numeric)

#create file
png(file = "plot4.png", width = 480, height = 480)

#layout in 2x2 format
par(mfrow=c(2,2))

#plot upper left graph (almost from problem #2)
plot(epc1$date_time,
     epc1$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active power"
)

#plot upper right graph
plot(epc1$date_time,
     epc1$Voltage,
     type ="l",
     xlab = "datetime",
     ylab = "voltage")

#plot lower left graph (from problem #3)
plot(epc1$date_time,
     epc1$Sub_metering_1,
     type = "l",
     xlab = "",
     ylab = "Energy sub metering"
)

lines(epc1$date_time,
      epc1$Sub_metering_2,
      col = "red"
)

lines(epc1$date_time,
      epc1$Sub_metering_3,
      col = "blue"
)

legend("topright",
       legend = c("Sub_metering_1",
                  "Sub_metering_2",
                  "Sub_metering_3"),
       col = c("black",
               "red",
               "blue"),
       lwd = c(2,
               2,
               2)
)


#plot lower right graph
plot(epc1$date_time,
     epc1$Global_reactive_power,
     type ="l",
     xlab = "datetime",
     ylab = "Global_reactive_power")

dev.off()