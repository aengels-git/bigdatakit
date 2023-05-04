#' convert_to_parquet
#'
#' @param infile path to a file to convert
#' @param outfile complete filepath with .parquet extension to the destination (defaults to same folder/filename as infile)
#' @param delimiter seperator used in the infile, defaults to csv
#'
#' @return
#' @export
#'
#' @examples
convert_to_parquet<-function(infile, outfile=NULL, delimiter=","){
  data <- read_delim_arrow(
    infile,
    delim = delimiter,
    as_data_frame = FALSE
  )
  if(is.null(outfile)){
    write_parquet(data, glue("{fs::path_ext_remove(infile)}.parquet"))
  } else {
    write_parquet(data, outfile)
  }

  rm(data)
  gc()
}