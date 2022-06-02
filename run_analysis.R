#function to convert text input to table
create_table<-function(num=1)
{
  
  
  feature_names<-fread("C:/Users/anebaner/Documents/Project 4/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/features.txt")
  activity_label<-fread("C:/Users/anebaner/Documents/Project 4/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt")
  tt<-c("train","test")
  Ig<-c("body_acc_", "body_gyro_","total_acc_")
  x_z<-c("x_","y_","z_")
  i<-num
  
  
  DT1<-fread(paste("C:/Users/anebaner/Documents/Project 4/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/",tt[i],"/subject_",tt[i],".txt",sep=""))
  
  print(DT1)
  
  activity_dataset<-fread(paste("C:/Users/anebaner/Documents/Project 4/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/",tt[i],"/y_",tt[i],".txt",sep=""))
  Activity_labeled<-merge(activity_dataset,activity_label)
  DT1<-cbind(DT1,unlist(Activity_labeled[,2]))
  print(DT1)
  DT1<-cbind(DT1,fread(paste("C:/Users/anebaner/Documents/Project 4/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/",tt[i],"/x_",tt[i],".txt",sep="")))
  print(head(DT1))
  j<-1
  count<-1
  colnames1<-""
  for(j in 1:3)
  {
    k<-1
    for (k in 1:3)
    {
      DT1<-cbind(DT1,fread(paste("C:/Users/anebaner/Documents/Project 4/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/",tt[i],"/Inertial Signals/",Ig[j],x_z[k],tt[i],".txt",sep="")))
      count<-1
      for(count in 1:128)
      {
        colnames1<-c(colnames1,paste(Ig[j],x_z[k],count,sep=""))
        
      }
    }
  }
  
  
  k<- unlist(colnames1)
  colnames(DT1)<-c("Subject","Activity",unlist(feature_names[,2]),k[2:1153])
  DT1
  
}
#function to merge training and test and only extract
mergeandextract<-function()
{
  DT_train<-create_table(1)
  
  
  DT_test<-create_table(2)
  
  DT_merged<-rbind(DT_train,DT_test)
  u<- colnames(DT_merged)
  cols1<-unlist(grep("std",u))
  cols2<-unlist(grep("mean",u))
  
  cols<-c(1,2,cols1,cols2)
  DT_extract<-subset(DT_merged,select=cols)
  print(DT_extract)
  
  print(cols)
  
  print(DT_extract) 
  DT_extract
  
}
#function to summarize by group and subject
summarize<-function()
{
  DT<-mergeandextract()
  data_group_subject<-DT[, lapply(.SD, mean),by=c("Subject","Activity")]
  write.table(data_group_subject,"Data Summary by Subject and Activity.txt",row.names =FALSE )
}

summarize()


