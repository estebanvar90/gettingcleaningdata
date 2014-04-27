#Set Work Directory
file.exists("UCI HAR Dataset") #make sure you have this folder in your work dir

#Read train
train<-readLines("UCI HAR Dataset/train/X_train.txt")
train2<-read.table(text=train,sep=" ",fill=T)
write.csv(train2,"train2.csv",header=F) #takes good time on doing it so it is better to save as a new file

train3<-as.data.frame(train2[1,!is.na(train2[1,])]) #takes NA created from spaces so you have 561 columns
for (i in 2:3000){
  train3[i,]<-train2[i,!is.na(train2[i,])]
} #completes the same task for the rest of the rows
for (i in 3001:7000){
  train3[i,]<-train2[i,!is.na(train2[i,])]
} 
for (i in 7001:11228){
  train3[i,]<-train2[i,!is.na(train2[i,])]
}
write.csv(train3,"train3.csv",row.names=F)

#Read test
test<-readLines("UCI HAR Dataset/test/X_test.txt")
test2<-read.table(text=test,sep=" ",fill=T)
write.csv(test2,"test2.csv",header=F) #takes good time on doing it so it is better to save as a new file

test3<-as.data.frame(test2[1,!is.na(test2[1,])]) #takes NA created from spaces so you have 561 columns
for (i in 2:2000){
  test3[i,]<-test2[i,!is.na(test2[i,])]
} #completes the same task for the rest of the rows
for (i in 2001:4312){
  test3[i,]<-test2[i,!is.na(test2[i,])]
}
write.csv(test3,"test3.csv",row.names=F)


#names of features
feat<-readLines("UCI HAR Dataset/features.txt")
features<-read.table(text=feat,sep=" ")
used.feat<-grep("mean\\(\\)|std\\(\\)",features$V2) #the requiered mean and std

#merge data
colnames(train3)<-features$V2
colnames(test3)<-features$V2
train3$group<-rep("train",nrow(train3))
test3$group<-rep("test",nrow(test3))
data1<-rbind(train3,test3)
identical(nrow(data1),nrow(test3)+nrow(train3))
data2<-data1[,used.feat]

#new tidy data
value<-rep(NA,ncol(data2))
for(i in 1:ncol(data2)){
  value[i]<-mean(data2[,i])
}
tidy<-data.frame(names(data2),value) #names become a variable so can be filtered
tidy$TYPE<-ifelse(grepl("mean",tidy$names.data2.)==TRUE,"mean","st deviation")
tidy$AXIS<-ifelse(grepl("X$",tidy$names.data2.)==TRUE,"X",
                  ifelse(grepl("Y$",tidy$names.data2.)==TRUE,"Y",
                         ifelse(grepl("Z$",tidy$names.data2.)==TRUE,"Z","magnitude")))
tidy$UNIT<-ifelse(grepl("^t",tidy$names.data2.),"time","fast fourier transform")
tidy$SENSOR<-ifelse(grepl("Acc",tidy$names.data2.),"ACCELERATOR","GYROSCOPE")
tidy$SIGNALS<-ifelse(grepl("Body",tidy$names.data2.),"BODY","GRAVITY")
tidy$JERK.SIGNAL<-ifelse(grepl("Jerk",tidy$names.data2.),"JERK","NO JERK")
names(tidy)[1]<-"Complete.Name"
write.csv(tidy,"tidy data.csv")
