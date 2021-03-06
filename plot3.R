# plot3.R
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
# plot 3
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
legend("topright", legend=ldes, lwd=c(2,0,1))
dev.copy(png,file="plot3.png")
dev.off()
