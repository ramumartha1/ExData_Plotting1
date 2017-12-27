library(data.table)
library(dplyr)

## Download the household_power_consumption.txt in the current working directory
    P_consumption<- fread('./household_power_consumption.txt', nrows=70000, sep=";", header=TRUE)
    P_consumption[P_consumption == "?"] <- NA
    
    
    P_consumption$Date <- as.Date(P_consumption$Date, "%d/%m/%Y")
    np <- with(P_consumption, P_consumption[(Date >= "2007-02-01" & Date <= "2007-02-02") ])
    
    rm(P_consumption)   ## Remove P_consumption as it no more needed.
    
    
    np$Global_active_power <- as.numeric(as.character(np$Global_active_power))
    np$Sub_metering_1 <- as.numeric(as.character(np$Sub_metering_1))
    np$Sub_metering_2 <- as.numeric(as.character(np$Sub_metering_2))
    np$Sub_metering_3 <- as.numeric(as.character(np$Sub_metering_3))
    np$Voltage <- as.numeric(as.character(np$Voltage))
    np$Global_reactive_power <- as.numeric(as.character(np$Global_reactive_power))
    
    np <- transform(np, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
    
## Plot4 Funcion: plot the multivariaent plots  
    
    plot4 <- function() {
        par(mfrow =c(2,2),mar= c(4,4,2,1))
        plot(np$timestamp, np$Global_active_power, type ="l",xlab ="", ylab= "Global Active Power")
        plot(np$timestamp, np$Voltage, type ="l",xlab ="datetime", ylab= "Voltage")
        plot(np$timestamp, np$Sub_metering_1, type ="l",xlab ="", ylab= "Energy Sub metering")
        lines(np$timestamp,np$Sub_metering_2, col ='red')
        lines(np$timestamp,np$Sub_metering_3, col ='blue')
        legend("topright", col = c("black","red","blue"),c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),
               lty=c(1,1), lwd = c(1,1), cex =0.75)
        plot(np$timestamp, np$Global_reactive_power, type ="l",xlab ="datetime", ylab= "Global Reactive Power")
        dev.copy(png,file="plot4.png",width =480, height =480)
        dev.off()
        
    }
    
    plot4()
    









