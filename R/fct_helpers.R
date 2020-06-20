
# convert from list of classes to a representation understood by each spreadsheet reader

# readr goes from c("numeric", "numeric") to "nn"

class_to_reader <- function(read_type, x){
  
  if(read_type == "readr"){
    
    return(paste(substr(x, 1, 1), collapse = ""))
  }
}

# class_to_reader(read_type = "readr", x)
