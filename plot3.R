#set the working directory to the location for downloaded and unzipped file household_power_consumption.txt
rawdata <- read.table(file="./household_power_consumption.txt",header=TRUE, sep=";")

#Filter data set for required dates
hhpwrcon <- rawdata[rawdata$Date == "1/2/2007" | rawdata$Date == "2/2/2007" ,]

#Data cleansing for date and time fields
hhpwrcon$newdate <- as.Date(hhpwrcon$Date,"%d/%m/%Y")
hhpwrcon$newtime <- strptime(paste(hhpwrcon$Date,hhpwrcon$Time), "%d/%m/%Y %H:%M:%S")

#Data cleansing for converting ? to NA values
hhpwrcon[hhpwrcon$Global_active_power =="?","Global_active_power"] <- NA
hhpwrcon[hhpwrcon$Global_reactive_power =="?","Global_reactive_power"] <- NA
hhpwrcon[hhpwrcon$Voltage =="?","Voltage"] <- NA
hhpwrcon[hhpwrcon$Global_intensity =="?","Global_intensity"] <- NA
hhpwrcon[hhpwrcon$Sub_metering_1 =="?","Sub_metering_1"] <- NA
hhpwrcon[hhpwrcon$Sub_metering_2 =="?","Sub_metering_2"] <- NA
hhpwrcon[hhpwrcon$Sub_metering_3 =="?","Sub_metering_3"] <- NA

png(filename = "./plot3.png", width = 480, height = 480)
plot(hhpwrcon$newtime,as.numeric(as.character(hhpwrcon$Sub_metering_1)),type="n", xlab="",ylab="Energy sub metering")
lines(hhpwrcon$newtime,as.numeric(as.character(hhpwrcon$Sub_metering_1)),type="l", col="black")
lines(hhpwrcon$newtime,as.numeric(as.character(hhpwrcon$Sub_metering_2)),type="l", col="red")
lines(hhpwrcon$newtime,as.numeric(as.character(hhpwrcon$Sub_metering_3)),type="l", col="blue")
legend("topright", legend=c("sub_metering_1","sub_metering_2","sub_metering_3"),col=c("black","red","blue"),lty=1)
dev.off()
