
See also: [Creating TAF datasets](Creating-TAF-datasets), [Bib
entries](Bib-entries), [Example data records (bib
entries)](Example-data-records).

This page was based on using the `icesTAF` package version `4.0.0` dated
`2022-09-07`.

This example requires a package to be installed that is not on CRAN.
Please ensure you have the package `stockasessment` by running

``` r
# Download and install stockassessment in R
install.packages("stockassessment", repos = "https://fishfollower.r-universe.dev")
```

The resulting TAF analysis created from this example is on GitHub:
[github.com/ices-taf-dev/wiki-example-2](https://github.com/ices-taf-dev/wiki-example-2),
if you dont want to build up the code yourself by following the example,
you can skip to the end and run on your computer by downloading the
complete code and running it like this:

``` r
# get code
run_dir <- download.analysis("ices-taf-dev/wiki-example-2")
# view downloaded code
browseURL(run_dir)

# run analysis
run.analysis(run_dir)
# view result
browseURL(run_dir)
```

## In this guide

  - [Creating an empty TAF project](#creating-an-empty-TAF-project)
  - [Adding SAM input data via a bootstrap
    script](#adding-sam-input-data-via-a-bootstrap-script)

## Creating an empty TAF project

First we create an empty TAF project, and in this case we will call it
`example-1`, and then moving our working directory to this folder. We do
this by running

``` r
taf.skeleton("example-2")
setwd("example-2")
```

resulting in the following:

``` r
 example-2       
  ¦--bootstrap   
  ¦   °--initial 
  ¦       °--data
  ¦--data.R      
  ¦--model.R     
  ¦--output.R    
  °--report.R    
```

## Adding SAM input data via a bootstrap script

Tso get the input data for a stock asseement run on
[stockassessment.org/](https://stockassessment.org/), we can use a short
script. It is provided here as code that will create the script for you
- normally you would create these scripts yourself.

``` r
cat('library(stockassessment)

# download model from stockassessment.org
fit <- fitfromweb("WBCod_2021_cand01")

# save to model folder
save(fit, file = "fit.rData")

',
  file = "bootstrap/sam_fit.R"
)
```

bootsrap scripts such as this one, goes in the `bootstrap` folder:

``` r
 example-2        
  ¦--bootstrap    
  ¦   °--sam_fit.R
  ¦--data.R       
  ¦--model.R      
  ¦--output.R     
  °--report.R     
```

a second script to get the fitted model object is given below:

``` r
cat('sam_assessment <- "WBCod_2021_cand01"

sam_dir <-
  paste0(
    "https://stockassessment.org/datadisk/stockassessment/userdirs/user3/",
    sam_assessment,
    "/data/"
  )

files <-
  paste0(
    c("cn", "cw", "dw", "lf", "lw", "mo", "nm", "pf", "pm", "survey", "sw"),
    ".dat"
  )

for (file in files) {
  download(paste0(sam_dir, file))
}

',
  file = "bootstrap/sam_data.R"
)
```

We can then add records for these scripts in the DATA.bib file using:

``` r
draft.data(
  data.files = NULL,
  data.scripts = c("sam_data", "sam_fit"),
  originator = "WGBFAS",
  title = c("SAM input data for ...", "SAM fitted object for ..."),
  year = 2021,
  period = "1985-2020",
  file = TRUE,
  append = FALSE
)
```

resulting the project looking like this:

``` r
 example-2         
  ¦--bootstrap     
  ¦   ¦--DATA.bib  
  ¦   ¦--sam_data.R
  ¦   °--sam_fit.R 
  ¦--data.R        
  ¦--model.R       
  ¦--output.R      
  °--report.R      
```

and after running

``` r
taf.bootstrap()
```

    ## [07:26:55] Bootstrap procedure running...

    ## Processing DATA.bib

    ## [07:26:55] * sam_data

    ## [07:26:56] * sam_fit

    ## Warning in checkMatrixPackageVersion(): Package version inconsistency detected.
    ## TMB was built with Matrix version 1.4.1
    ## Current Matrix version is 1.5.0
    ## Please re-install 'TMB' from source using install.packages('TMB', type = 'source') or ask CRAN for a binary version of 'TMB' matching CRAN's 'Matrix' package

    ## [07:26:57] Bootstrap procedure done

your project should now look like this:

``` r
 example-2                 
  ¦--bootstrap             
  ¦   ¦--DATA.bib          
  ¦   ¦--data              
  ¦   ¦   ¦--sam_data      
  ¦   ¦   ¦   ¦--cn.dat    
  ¦   ¦   ¦   ¦--cw.dat    
  ¦   ¦   ¦   ¦--dw.dat    
  ¦   ¦   ¦   ¦--lf.dat    
  ¦   ¦   ¦   ¦--lw.dat    
  ¦   ¦   ¦   ¦--mo.dat    
  ¦   ¦   ¦   ¦--nm.dat    
  ¦   ¦   ¦   ¦--pf.dat    
  ¦   ¦   ¦   ¦--pm.dat    
  ¦   ¦   ¦   ¦--survey.dat
  ¦   ¦   ¦   °--sw.dat    
  ¦   ¦   °--sam_fit       
  ¦   ¦       °--fit.rData 
  ¦   ¦--sam_data.R        
  ¦   °--sam_fit.R         
  ¦--data.R                
  ¦--model.R               
  ¦--output.R              
  °--report.R              
```

Now we have a folder with the same name as the script we created, and
inside this is any files created by the script.
