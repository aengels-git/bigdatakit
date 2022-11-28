
<!-- README.md is generated from README.Rmd. Please edit that file -->

# bigdatakit

<!-- badges: start -->
<!-- badges: end -->

The goal of bigdatakit is to convert large csv files to parquet files

## Installation

You can install the development version of bigdatakit from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("aengels-git/bigdatakit")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(bigdatakit)
#> Lade nötiges Paket: arrow
#> 
#> Attache Paket: 'arrow'
#> Das folgende Objekt ist maskiert 'package:utils':
#> 
#>     timestamp
#> Lade nötiges Paket: dplyr
#> 
#> Attache Paket: 'dplyr'
#> Die folgenden Objekte sind maskiert von 'package:stats':
#> 
#>     filter, lag
#> Die folgenden Objekte sind maskiert von 'package:base':
#> 
#>     intersect, setdiff, setequal, union
#> Lade nötiges Paket: DT
#> Lade nötiges Paket: fs
#> Lade nötiges Paket: glue
#> Lade nötiges Paket: rlang
#> 
#> Attache Paket: 'rlang'
#> Das folgende Objekt ist maskiert 'package:arrow':
#> 
#>     string
## basic example code
library(tidyverse)
#> ── Attaching packages
#> ───────────────────────────────────────
#> tidyverse 1.3.2 ──
#> ✔ ggplot2 3.4.0     ✔ purrr   0.3.4
#> ✔ tibble  3.1.8     ✔ stringr 1.4.1
#> ✔ tidyr   1.2.1     ✔ forcats 0.5.2
#> ✔ readr   2.1.3     
#> ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
#> ✖ purrr::%@%()         masks rlang::%@%()
#> ✖ purrr::as_function() masks rlang::as_function()
#> ✖ dplyr::filter()      masks stats::filter()
#> ✖ purrr::flatten()     masks rlang::flatten()
#> ✖ purrr::flatten_chr() masks rlang::flatten_chr()
#> ✖ purrr::flatten_dbl() masks rlang::flatten_dbl()
#> ✖ purrr::flatten_int() masks rlang::flatten_int()
#> ✖ purrr::flatten_lgl() masks rlang::flatten_lgl()
#> ✖ purrr::flatten_raw() masks rlang::flatten_raw()
#> ✖ purrr::invoke()      masks rlang::invoke()
#> ✖ dplyr::lag()         masks stats::lag()
#> ✖ purrr::splice()      masks rlang::splice()
#> ✖ rlang::string()      masks arrow::string()
big_diamonds <- map(1:100,function(i){
  diamonds
})%>%reduce(rbind)
write_csv(big_diamonds,"big_diamonds.csv")

require(tictoc)
#> Lade nötiges Paket: tictoc
tic()
big_diamonds <- read_csv("big_diamonds.csv")
#> Rows: 5394000 Columns: 10
#> ── Column specification ────────────────────────────────────────────────────────
#> Delimiter: ","
#> chr (3): cut, color, clarity
#> dbl (7): carat, depth, table, price, x, y, z
#> 
#> ℹ Use `spec()` to retrieve the full column specification for this data.
#> ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
toc()
#> 2.93 sec elapsed
#3.03 sec elapsed

#Conversion happens mostly out of memory
tic()
convert_to_parquet("big_diamonds.csv")
#>            used  (Mb) gc trigger   (Mb)  max used   (Mb)
#> Ncells  1481763  79.2    2498990  133.5   2498990  133.5
#> Vcells 56847002 433.8  135524544 1034.0 135524544 1034.0
toc()
#> 3 sec elapsed
#3.36 sec elapsed

tic()
big_diamonds <- read_parquet("big_diamonds.parquet")
toc()
#> 0.68 sec elapsed
#0.61 sec elapsed
```
