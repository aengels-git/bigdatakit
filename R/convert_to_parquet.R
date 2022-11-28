#' convert_to_parquet
#'
#' @param infile path to a file to convert
#' @param delimiter seperator used in the infile, defaults to csv
#'
#' @return
#' @export
#'
#' @examples
convert_to_parquet<-function(infile,delimiter=","){
  data <- read_delim_arrow(
    infile,
    delim = delimiter,
    as_data_frame = FALSE
  )
  
  write_parquet(data, glue("{fs::path_ext_remove(infile)}.parquet"))
  rm(data)
  gc()
}