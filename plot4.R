# plot4.R
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
par(mfcol=c(2,2))
# plot row 1 col 1
with(df1,
     plot(datTim,Global_active_power,type='l',xlab='',
          ylab="Global Active Power (kilowatts)"))
# plot row 2 col 1
with(df1,
  plot(datTim,Sub_metering_1,type='l',lwd=2, xlab='',
       ylab="Energy sub metering"))

with(df1,  
  points(datTim,Sub_metering_2,type='l',lwd=0,
       xlab='' ))
with(df1,  
  points(datTim,Sub_metering_3,type='l',lwd=1,
       xlab=''))
ldes = c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
legend("topright", legend=ldes, lwd=c(2,0,1),cex=.5)
# plot row 1 col 2
with(df1,
     plot(datTim,Voltage,type='l',xlab="datetime"))
# plot row 2 col 2
with(df1,
     plot(datTim,Global_reactive_power,type='l',xlab="datetime"))
dev.copy(png,file="plot4.png")
dev.off()
