
# Look at type of columns
# Strings?
# THEN
# Dates, with gaps and if Excel converted to a number

# file_path <- "tests/testthat/test_files/upload_example.csv"

clean_data <- function(file_path, skip = 0, col_names = TRUE, col_types = NULL){
  
  extension <- tools::file_ext(file_path)
  
  if(!extension %in% c("csv", "tsv", "tab", "xls", "xlsx")){
    
    return("This file type is not supported")
  }
  
  if(extension == "csv"){
    
    return(readr::read_csv(file_path, skip = skip, col_names = col_names, col_types = col_types))
  }
  
  if(extension == "xls"){
    
    return(readxl::read_xls(file_path, skip = skip, col_names = col_names))
  }
  
  if(extension == "xlsx"){
    
    return(readxl::read_xlsx(file_path, skip = skip, col_names = col_names))
  }
  
  if(extension %in% c("tsv", "tab")){
    
    return(readr::read_tsv(file_path, skip = skip, col_names = col_names))
  }
}

# clean_data(file_path, skip = 1, col_names = c("Gap time", "Time", "Date"))

