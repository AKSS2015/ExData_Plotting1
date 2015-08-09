#First we make a tiny dataframe wid the first 10 cases only and wid Date and Time treated as
#character vectors only & not converted to factors
initial <-
  read.table(
    "household_power_consumption.txt", sep = ";", header = TRUE,
    nrows = 10, stringsAsFactors = FALSE, na.strings = "?"
  )

#head(initial)
str(initial)
Classes <- sapply(initial, class)
#Storing the class of each of the 9 variables in initial as the vector named classes.
tabAll <-
  read.table(
    "household_power_consumption.txt", sep = ";", header = TRUE,
    nrows = 2075260, colClasses = Classes, comment.char = "", na.strings = "?"
  )
# tabAll is the full dataset with Date and Time treated as char vectors only &
# not converted to factors
datetime <- paste(tabAll$Date, tabAll$Time, sep = " ")
#Combining these two vectors in one, called "datetime" with both the dates and time
#using paste
datetime <- strptime(datetime, format = "%d/%m/%Y %H:%M")
d <- data.frame(datetime, tabAll)
str(d)
myfinaldata <-
  d[d$Date %in% c("1/2/2007", "2/2/2007"),] # This subsets the dataframe
#to extract the data for the two required dates

par(mfcol = c(2, 2))# to create the 4-panel plot columnwise
par(mar = c(4,5,2,2))# setting the four margins so the y-axis labels are visible
with (myfinaldata,{
  plot(
    datetime, Global_active_power, type = "l", ylab = "Global Active
    Power", xlab = " "
  )
  
  plot(
    myfinaldata$datetime, myfinaldata$Sub_metering_1,
    col = "black", type = "l", ylab = "Energy sub metering", xlab = " "
  )
  with (myfinaldata, lines(myfinaldata$datetime, myfinaldata$Sub_metering_2, col = "red"))
  with (
    myfinaldata, lines(myfinaldata$datetime, myfinaldata$Sub_metering_3, col = "blue")
  )
  legend (
    "topright", lty = 1, col = c("black", "red", "blue"),
    legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
    cex = 0.5, bty = "n"
  )
  #using 'cex' for resizing and 'bty' for boxline type (none) both inside of legend()
  plot(datetime, Voltage, type = "l")
  
  plot(datetime, Global_reactive_power, type = "l")
  
})
