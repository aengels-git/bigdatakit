#' grab_paths
#'
#' @param path folder that contains the files to detect
#' @param pattern restrict files to those that match this regex pattern
#'
#' @return
#' @export
#'
#' @examples 
grab_paths<-function(path,pattern="."){
  info_table <- fs::dir_info(path)%>%
    filter(str_detect(path,pattern = pattern))%>%
    mutate(file=fs::path_file(path))%>%
    select(file,size,path)
  glue("New table would consists of {sum(info_table$size)} of data")|>print()
  return(info_table)
}