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

# create file and plot line graph
png(file = "plot3.png", width = 480, height = 480)
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
dev.off()
