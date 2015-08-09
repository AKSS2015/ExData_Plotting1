initial <-
  read.table(
    "household_power_consumption.txt", sep = ";", header = TRUE,
    nrows = 10, stringsAsFactors = FALSE, na.strings = "?"
  )
#Made a tiny dataframe wid d first 10 cases only and wid Date and Time treated as char vectors only & not converted to factors
#head(initial)
str(initial)
Classes <- sapply(initial, class)
#Storing the class of each of the 9 variables in initial as the vector named classes.
tabAll <-
  read.table(
    "household_power_consumption.txt", sep = ";", header = TRUE,
    nrows = 2075260, colClasses = Classes, comment.char = "", na.strings = "?"
  )
# tabAll is d full dataset wid Date and Time treated as char vectors only & not converted to factors
datetime <- paste(tabAll$Date, tabAll$Time, sep = " ")
#Combining these two vectors in one, called "datetime" with both the dates and time
#using paste
datetime <- strptime(datetime, format = "%d/%m/%Y %H:%M")
d <- data.frame(datetime, tabAll)
str(d)
myfinaldata <- d[d$Date %in% c("1/2/2007", "2/2/2007"),]
str(myfinaldata)
length(myfinaldata$Global_active_power)
par( mfcol = c(1, 1))
#To generate the first plot
hist(
  myfinaldata$Global_active_power, col = "red", border = "black",
  xlab = "Global Active Power(kilowatts)", main = paste("Global Active Power")
)