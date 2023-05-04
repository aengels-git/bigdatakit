find_bigdatakit <- function(){
  development = T
  if(development==T){
    return("C:/Users/alex-/Documents/Methodik/Github R Pakete/bigdatakit/inst")
  }
  map(.libPaths(),function(current_lib){
    if(any(list.files(current_lib) %in% "bigdatakit")){
      return(paste0(current_lib,"/bigdatakit"))
    }
  })%>%reduce(c)
}


#' calculate huber scales
#'
#' @param data dataset
#' @param id as string or character vector, required because merge is based on joins that require an id
#' @param atc_variable as string
#'
#' @return
#' @export
#'
#' @examples
calculate_huber <- function(data,id,atc_variable){

  huber <- read_delim(paste0(find_bigdatakit(),"/huber.csv"),delim=";")
  
  huber_scales<-pmap(list(
    huber$subscale,
    str_replace_all(huber$atc,"[:space:]","")
  ),function(name,selector){
    
    # name <- huber$subscale[8]
    # selector <- str_replace_all(huber$atc,"[:space:]","")[8]
    selector <- paste0("^",str_split(selector,",")%>%unlist()) # add a ^ sign to search for the pattern at the beginning of the atc code only!
    
    #Create regex for current scale:
    regex<-str_c(selector,collapse = "|")
    
    #Filter Exposed data to those that fulfill the condition for the current scale
    data%>%
      filter(grepl(regex , !!parse_expr(atc_variable) ))%>%
      mutate(!!parse_expr(name) := 1)%>%
      select(!!!parse_exprs(id),!!parse_expr(name))%>%
      #Remove Duplicates:
      filter(duplicated(.)==F)
  })%>%reduce(full_join)
  
  return(data%>%
    select(!!!parse_exprs(id))%>%
    left_join(huber_scales)%>%
   mutate_if(str_detect(names(.),"^Hub_S"),function(x){ifelse(is.na(x),0,1)}))
}


