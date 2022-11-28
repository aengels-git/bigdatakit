#' convert_files_to_parquet
#'
#' @param infiles vector of file paths 
#' @param outfile name of the outfile with an extension i.e. outfile.parquet
#' @param format format of the infiles
#' @param delimiter delimiter used in the infiles
#'
#' @return
#' @export
#'
#' @examples
convert_files_to_parquet <- function(infiles,outfile,
                                     format = "csv", delimiter = ","){

  relevant_dir <- fs::path_dir(infiles[1])
  parquet_dir <- glue("{relevant_dir}/parquet")
  
  data_stream <- open_dataset(infiles, format = format, delimiter = delimiter)
  if(fs::dir_exists(parquet_dir)==F){
    fs::dir_create(parquet_dir)
  }
  
  data_stream%>%
    write_dataset(glue("{parquet_dir}/{fs::path_ext_remove(outfile)}"), 
                  format = "parquet")
  
  file.rename(glue("{parquet_dir}/{fs::path_ext_remove(outfile)}/part-0.parquet"),
              glue("{parquet_dir}/{fs::path_ext_remove(outfile)}/{outfile}"))
  
  fs::file_move(glue("{parquet_dir}/{fs::path_ext_remove(outfile)}/{outfile}"),
                parquet_dir)
  fs::dir_delete(glue("{parquet_dir}/{fs::path_ext_remove(outfile)}"))
  
}