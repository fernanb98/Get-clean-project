condense<-function(file1,file2,oldtags="",newtag=""){
  #**************************************************************************** 
  # condense(file1, file2, oldtags, newtag)                                   *
  # This function creates a new file, merging the contents of file1 and file2 *
  # Files will be merged by row                                               *
  #                                                                           *
  # Input: file1, file2  this are the files to join                           *
  #        oldtags is a string containing the parts of input filenames to be  *
  #        substituted to create the new filename for the joined output file  *
  #        newtag will be part of the output filename, substitute oldtags     *
  # Output: new file with content of both input files merged by row           *
  #****************************************************************************
  df1<-read.csv(file1,sep="",header=FALSE)
  df2<-read.csv(file2,sep="",header=FALSE)
  df3<-rbind(df1,df2)
  filename<-gsub(oldtags,newtag,file1)
  result<-write.table(df3, file=filename, col.names=F, row.names=F)
}
