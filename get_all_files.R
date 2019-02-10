getallfiles<-function(subdirectories){
  
  #**************************************************************************** 
  # getallfiles(subdirectories)                                               *               *
  # This function returns a list of .txt filenames for a vector of            *
  # subdirectory names                                                        *
  # Input: subdirectories vector containing subdirectories to scan            *
  # Output: list of files in each subdirectory                                *
  #****************************************************************************
  
  allfiles<-NULL
  for (section in subdirectories){
    files<-list.files(section,
                      pattern="\\.txt$",
                      full.names=TRUE,
                      recursive=TRUE)
    
    allfiles[[section]]<-files
  }
  return(allfiles)
}