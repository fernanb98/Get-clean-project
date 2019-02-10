extract<-function(file,columns=1,separator="",header=FALSE){
  #**************************************************************************** 
  # extract(file, columns, separator, header)                                 *               *
  # This function reads a data file and  returns a dataframe with a subset    *
  # of its columns                                                            *
  # Input: file is the file to read                                           *
  #      columns are the columns required, default only first column          *
  #      separator is the character that separates columns in the file        *
  #      header TRUE if file contains a header row                            *
  # Output: dataframe with only required columns                              *
  #****************************************************************************
  df<-read.csv(file,sep=separator,header=header)
  return(df[,columns])
}