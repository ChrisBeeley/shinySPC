
# Dates, with gaps and if Excel converted to a number
# Strings?
# 
# THEN
# 
# Look at type of columns
# 
# THEN

# start with a filepath send from the reactive load_data module

clean_data <- function(file_path, skip = 0, col_names = TRUE){
  
  extension <- tools::file_ext(file_path)
  
  if(!extension %in% c("csv", "tsv", "tab", "xls", "xlsx")){
    
    return("This file type is not supported")
  }
  
  if(extension == "csv"){
    
    return(readr::read_csv(file_path, skip = skip, col_names = col_names))
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

# clean_data(file_path)

# # this is a later example
# 
# file_path_n <- "example_data/weekly_deaths.xls"