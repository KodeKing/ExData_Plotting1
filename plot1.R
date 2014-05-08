# plot1.R
dir="C:/Users/Jack/Documents/EducationalCourses/ExplDataAnly/Prj1"
fnam = paste(dir,"household_power_consumption.txt",sep="/")
df <- read.table(fnam,header=TRUE, sep=";",na.strings = "?",
                 stringsAsFactors=FALSE)
df$dat = as.Date(df$Date,"%d/%m/%Y")
# lop off dates beyond 2007-02-02
df1 <- df[df$dat<=as.Date("2007-02-02"),]
# remove early dates
df1 <- df1[df1$dat>=as.Date("2007-02-01"),]
# df1 contains dates 2007-02-01 to 2007-02-02
# need a single field for date and time
# use POSIXct format
df1$datTim <- as.POSIXct(paste(df1$dat,df1$Time,sep=' '),
                         format="%Y-%m-%d %H:%M:%S",tz="UTC")
# Plot 1
hist(df1$Global_active_power,
     xlab="Global Active Power (kilowatts)",
     main="Global Active Power")
dev.copy(png,file="plot1.png")
dev.off()
