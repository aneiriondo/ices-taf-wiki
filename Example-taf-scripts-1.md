
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
[github.com/ices-taf-dev/wiki-example-3](https://github.com/ices-taf-dev/wiki-example-3),
if you dont want to build up the code yourself by following the example,
you can skip to the end and run on your computer by downloading the
complete code and running it like this:

``` r
# get code
run_dir <- download.analysis("ices-taf-dev/wiki-example-3")
# view downloaded code
browseURL(run_dir)

# run analysis
run.analysis(run_dir)
# view result
browseURL(run_dir)
```

## In this guide

  - [Creating an empty TAF project](#creating-an-empty-TAF-project)
  - [Preprocess the data](#preprocess-the-data)
  - [Running a model](#running-a-model)
  - [Writing TAF tables](#writing-taf-tables)
  - [Formatted output for reporting](#formatted-output-for-reporting)

## Creating an empty TAF project

First we create an empty TAF project set up with a bootstrap section for
a stock assessment created on stock
[stockassessment.org/](https://stockassessment.org/), and in this case
we will call it `example-3`, and then moving our working directory to
this folder. We do this by running

``` r
taf.skeleton.sa.org("example-3", "WBCod_2021_cand01")
setwd("example-3")
```

resulting in the following:

``` r
 example-3         
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

    ## [08:08:26] Bootstrap procedure running...

    ## Processing DATA.bib

    ## [08:08:26] * sam_data

    ## [08:08:27] * sam_fit

    ## [08:08:27] Bootstrap procedure done

your project should now look like this:

``` r
 example-3                 
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

## Running a model

## Writing TAF tables

## Formatted output for reporting
