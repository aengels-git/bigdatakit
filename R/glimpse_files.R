quick_dt<-function(table,pl=10,ndigits=2,...){
  table%>%
    mutate_if(is.numeric,function(x){round(x,digits = ndigits)})%>%
    DT::datatable(options = list(pageLength = pl,
                                 dom="t",...))
}

#' glimpse_files
#'
#' @param infiles vector of file paths
#' @param n number of rows to read in 
#' @param delimiter delimiter
#'
#' @return
#' @export
#'
#' @examples
glimpse_files<-function(infiles,n=10,delimiter=","){
  tabs <- map(infiles,function(file){
    read_delim(file,n_max = n,delim=delimiter)
  })
  map2(infiles,tabs,function(file,tab){
    list(
      tags$h1(fs::path_file(file)),
      tags$h2(fs::file_info(file)$size),
      tags$div(quick_dt(tab,pl=n))
    )
  })%>%tagList()%>%browsable()
}