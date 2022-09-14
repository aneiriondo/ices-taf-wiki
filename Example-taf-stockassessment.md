
See also: [Getting set up](Getting-set-up), [Running a TAF
analysis](Running-a-TAF-analysis), [Creating TAF
datasets](Creating-TAF-datasets).

This page was based on using the `icesTAF` package version `4.0.1` dated
`2022-09-07`.

This example requires a package to be installed that is not on CRAN.
Please ensure you have the package `stockasessment` by running

``` r
# Download and install stockassessment in R
install.packages("stockassessment", repos = "https://fishfollower.r-universe.dev")
```

The resulting TAF analysis created from this example is on GitHub:
[github.com/ices-taf-dev/wiki-example-stockassessment](https://github.com/ices-taf-dev/wiki-example-stockassessment),
if you dont want to build up the code yourself by following the example,
you can skip to the end and run on your computer by downloading the
complete code and running it like this:

``` r
# get code
run_dir <- download.analysis("ices-taf-dev/wiki-example-stockassessment")
# view downloaded code
browseURL(run_dir)

# run analysis
run.analysis(run_dir)
# view result
browseURL(run_dir)
```

## In this guide

  - [Creating an empty stockassessment.org TAF
    project](#creating-an-empty-stockassessment.org-TAF-project)
  - [Preprocess the data](#preprocess-the-data)
  - [Running a model](#running-a-model)
  - [Writing TAF tables](#writing-taf-tables)
  - [Formatted output for reporting](#formatted-output-for-reporting)

## Creating an empty stockassessment.org TAF project

First we create an empty TAF project set up with a bootstrap section for
a stock assessment created on stock
[stockassessment.org/](https://stockassessment.org/), and in this case
we will call it `example-4` and choose the run called:
`WBCod_2021_cand01`, and then moving our working directory to this
folder. We do this by running

``` r
taf.skeleton.sa.org("example-4", "WBCod_2021_cand01")
```

    ## To run this template please ensure you have the package:
    ##  stockasessment
    ## by running:
    ##  install.packages("stockassessment", repos = "https://fishfollower.r-universe.dev")

``` r
setwd("example-4")
```

resulting in the following:

    ## repo: ices-taf-dev/wiki-example-stockassessment has been downloaded to: C:\Users\colin\AppData\Local\Temp\RtmpCQwXHh

``` r
 example-4         
  ¦--bootstrap     
  ¦   ¦--initial   
  ¦   ¦   °--data  
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

    ## [08:46:25] Bootstrap procedure running...

    ## Processing DATA.bib

    ## [08:46:25] * sam_data

    ## [08:46:26] * sam_fit

    ## Warning in checkMatrixPackageVersion(): Package version inconsistency detected.
    ## TMB was built with Matrix version 1.4.1
    ## Current Matrix version is 1.5.0
    ## Please re-install 'TMB' from source using install.packages('TMB', type = 'source') or ask CRAN for a binary version of 'TMB' matching CRAN's 'Matrix' package

    ## [08:46:27] Bootstrap procedure done

your project should now look like this:

``` r
 example-4                 
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

Now we have a input data and the fitted model object that we can use to
create some standard TAF files.

## Preprocess the data

Now that you have created the file structure and uploaded your data,
it’s time to turn your attention to the `data.R` script. The purpose
of this script is to do some data processing. This could be (among other
things):

  - calculating a plus group,
  - taking averages of survey indices,
  - calculating fill-in values and removing outliers,
  - calculating smoothed time series

The `data.R` script should also write out input data into flat `.csv`
files, so they are readable and reviewable by others.

In this section we will build the script up in sections. First we need
to load the libraries and get the data required for the script. It is
good practice to write your analysis in several scripts with each script
being as independent as possible. This will allow you to return to your
analysis and work on a specific section, and not worry too much about
whether you have loaded the correct libraries and data. So the first
step is always to load libraries, then load the data required.

It is also considered good practice to create (or ensure) that the
output directory for the TAF section you are working in exists. Hence
the start of your script will be structured like this:

``` r
## Preprocess data, write TAF data tables

## Before:
## After:

## load libraries
library(icesTAF)
library(stockassessment)

# ensure directory
mkdir("data")

#  Read underlying data from bootstrap/data
# ...
```

For the example we are working with here this becomes

``` r
## Preprocess data, write TAF data tables

## Before:
## After:

## load libraries
library(icesTAF)
library(stockassessment)

# ensure directory
mkdir("data")

#  Read underlying data from bootstrap/data

#  ## Catch-numbers-at-age ##
catage <- read.ices(taf.data.path("sam_data/cn.dat"))

#  ## Catch-weight-at-age ##
wcatch <- read.ices(taf.data.path("sam_data/cw.dat"))
wdiscards <- read.ices(taf.data.path("sam_data/dw.dat"))
wlandings <- read.ices(taf.data.path("sam_data/lw.dat"))

#  ## Natural-mortality ##
natmort <- read.ices(taf.data.path("sam_data/nm.dat"))

#  ## Proportion of F before spawning ##
propf <- read.ices(taf.data.path("sam_data/pf.dat"))

#  ## Proportion of M before spawning ##
propm <- read.ices(taf.data.path("sam_data/pm.dat"))

#  ## Stock-weight-at-age ##
wstock <- read.ices(taf.data.path("sam_data/sw.dat"))

# Landing fraction in catch at age
landfrac <- read.ices(taf.data.path("sam_data/lf.dat"))
```

The next step is to do any preprocessing or calculations that you may
need to do. In this simple example we don’t need to do much

``` r
## 2 Preprocess data

# landings
latage <- catage * landfrac[, -1]
datage <- catage * (1 - landfrac[, -1])
```

And finally when we are done, it is recommended that you write out your
input data in a human (easily) readable form. CSV is always a good
option as it is easily read into R and Excel etc.

``` r
## 3 Write TAF tables to data directory
write.taf(
  c(
    "catage", "latage", "datage", "wstock", "wcatch",
    "wdiscards", "wlandings", "natmort", "propf", "propm",
    "landfrac"),
  dir = "data"
)
```

And this concludes the data script. To test the script you can run
\`sourceTAF(“data”)

``` r
sourceTAF("data")
```

    ## [08:46:27] data.R running...

    ## [08:46:27]   data.R done

your project should now look like this:

``` r
 example-4                 
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
  ¦--data                  
  ¦   ¦--catage.csv        
  ¦   ¦--datage.csv        
  ¦   ¦--landfrac.csv      
  ¦   ¦--latage.csv        
  ¦   ¦--natmort.csv       
  ¦   ¦--propf.csv         
  ¦   ¦--propm.csv         
  ¦   ¦--wcatch.csv        
  ¦   ¦--wdiscards.csv     
  ¦   ¦--wlandings.csv     
  ¦   °--wstock.csv        
  ¦--model.R               
  ¦--output.R              
  °--report.R              
```

## Running a model

## Writing TAF tables

## Formatted output for reporting
