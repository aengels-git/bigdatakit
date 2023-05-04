library(devtools)
load_all()

#Grab paths of multiple file with a specific pattern
bigdatakit::grab_paths(".",pattern = "csv")

#Convert one file
convert_to_parquet("big_diamonds.csv",outfile = "./big_diamonds.parquet") 


#Calculate huber
df<-data.frame(
  id=c(1,2,3,3),
  fallnummer=c(1,2,3,4),
  atc=c("M05","S01E","Not an ATC","N05A")
)

calculate_huber(data=df,id =c("id","fallnummer"),atc_variable = "atc")
