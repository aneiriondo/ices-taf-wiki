
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

    ## [09:10:48] Bootstrap procedure running...

    ## Processing DATA.bib

    ## [09:10:48] * sam_data

    ## [09:10:49] * sam_fit

    ## [09:10:49] Bootstrap procedure done

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
`sourceTAF("data")`

``` r
sourceTAF("data")
```

    ## [09:10:50] data.R running...

    ## [09:10:50]   data.R done

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

Although in this example the model has already been run elsewhere, we
can still choose to rerun the model or even conduct further analyses.
Here we load the model from the `bootstrap/data` folder and run a
retrospective analysis. then save the results in the model folder.

``` r
## Run analysis, write model results

## Before:
## After:

library(icesTAF)

mkdir("model")

(load(taf.data.path("sam_fit/fit.RData")))

retro_fit <- stockassessment::retro(fit, year = 2017:2021)

save(fit, file = "model/fit.RData")
save(retro_fit, file = "model/retro_fit.RData")
```

And this concludes the model script. To test the script you can run
`sourceTAF("model")`

``` r
sourceTAF("model")
```

    ## [09:10:50] model.R running...

    ## [09:11:06]   model.R done

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
  ¦--model                 
  ¦   ¦--fit.RData         
  ¦   °--retro_fit.RData   
  ¦--output.R              
  °--report.R              
```

## Writing TAF tables

In the output section we take the model and any aditional analyses and
create human readable, but full precision, outputs. This is much like
the data section, but we are dealing with model outputs.

``` r
## Extract results of interest, write TAF output tables

## Before:
## After:

library(icesTAF)

mkdir("output")

## Extract results of interest, write TAF output tables

## Before:
## After: csv tables of assessment output

library(icesTAF)
library(stockassessment)

mkdir("output")

# load fit
(load("model/fit.rData"))

# Model Parameters
partab <- partable(fit)

# Fs
fatage <- faytable(fit)
fatage <- fatage[, -1]
fatage <- as.data.frame(fatage)

# Ns
natage <- as.data.frame(ntable(fit))

# Catch
catab <- as.data.frame(catchtable(fit))
colnames(catab) <- c("Catch", "Low", "High")

# TSB
tsb <- as.data.frame(tsbtable(fit))
colnames(tsb) <- c("TSB", "Low", "High")

# Summary Table
tab.summary <- cbind(as.data.frame(summary(fit)), tsb)
tab.summary <- cbind(tab.summary, rbind(catab, NA))
# should probably make Low and High column names unique R_Low etc.

mohns_rho <- mohn(retro_fit)
mohns_rho <- as.data.frame(t(mohns_rho))

## Write tables to output directory
write.taf(
  c("partab", "tab.summary", "natage", "fatage", "mohns_rho"),
  dir = "output"
)
```

This concludes the ouput script. To test the script you can run
`sourceTAF("output")`

``` r
sourceTAF("output")
```

    ## [09:11:06] output.R running...

    ## Warning in FUN(X[[i]], ...): duplicated column names

    ## [09:11:06]   output.R done

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
  ¦--model                 
  ¦   ¦--fit.RData         
  ¦   °--retro_fit.RData   
  ¦--output.R              
  ¦--output                
  ¦   ¦--fatage.csv        
  ¦   ¦--mohns_rho.csv     
  ¦   ¦--natage.csv        
  ¦   ¦--partab.csv        
  ¦   °--tab_summary.csv   
  °--report.R              
```

## Formatted output for reporting

It is often of use to split up the reporting into several scripts. This
can be done in any section, but is most common in the report section. Do
do this, you create scripts called `report_*.R` and your `report.R`
script becomes a like a recipe, that sources each relavent script in
turn. In this example we are going to make three seperate scripts, and
an R markdown script to create a report:

  - report\_plots.R
  - report\_tables.R
  - report\_doc.R
  - report.Rmd

This means that the central `report.R` script will look like this:

``` r
## Prepare plots and tables for report

## Before:
## After:

library(icesTAF)

mkdir("report")

sourceTAF("report_plots.R")
sourceTAF("report_tables.R")
sourceTAF("report_doc.R")
```

The contents of these scripts are very much incomplete and are here just
to serve as an example. A simple example of the `report_plots.R` script
is:

``` r
library(icesTAF)
library(stockassessment)

mkdir("report")

load("model/fit.rData")
load("model/retro_fit.rData")

## input data plots

## ....

## model output plots ##
taf.png("summary", width = 1600, height = 2000)
plot(fit)
dev.off()

taf.png("SSB")
ssbplot(fit, addCI = TRUE)
dev.off()

taf.png("Fbar")
fbarplot(fit, xlab = "", partial = FALSE)
dev.off()

taf.png("Rec")
recplot(fit, xlab = "")
dev.off()

taf.png("Landings")
catchplot(fit, xlab = "")
dev.off()

taf.png("retrospective", width = 1600, height = 2000)
plot(retro_fit)
dev.off()
```

and this can be run and tested using `sourceTAF("report_plots")`, or
simply `source("report_plots.R")`

A simple `report_tables.R` script is

``` r
mkdir("report")

(load("model/fit.RData"))

years <- unique(fit$data$aux[, "year"])

## catage
catage <- read.taf("data/catage.csv")
# row.names(catage) <- years[1:nrow(catage)]

catage <- cbind(catage, total = rowSums(catage))
catage <- rbind(catage, mean = colMeans(catage))

write.taf(catage, "report/catage.csv")
```

And the `report_doc.R` script will generally look like this

``` r
library(rmarkdown)

source("utilities.R")

mkdir("report")

# combine into a word and html document
render("report.Rmd",
  output_format = c("word_document", "html_document"),
  encoding = "UTF-8"
)

# move to report folder
cp("report.html", "report", move = TRUE)
cp("report.docx", "report", move = TRUE)
```

The `report.Rmd` script is very much an example and not a suggestion.
(more to come later).

The code is found here:
[report.Rmd](https://github.com/ices-taf-dev/wiki-example-stockassessment/blob/main/report.Rmd)

Once all this code is in place the whole report section can be run
`sourceTAF("report")`

``` r
sourceTAF("report")
```

    ## [09:11:06] report.R running...

    ## [09:11:06] report_plots.R running...

    ## [09:11:08]   report_plots.R done

    ## [09:11:08] report_tables.R running...

    ## [09:11:08]   report_tables.R done

    ## [09:11:08] report_doc.R running...

    ## Warning in file(filename, "r", encoding = encoding): cannot open file 'utilities.R': No such file or directory

    ## Error in file(filename, "r", encoding = encoding) : 
    ##   cannot open the connection

    ## [09:11:08]   report_doc.R failed

    ## [09:11:08]   report.R done

your completed project should now look like this:

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
  ¦--model                 
  ¦   ¦--fit.RData         
  ¦   °--retro_fit.RData   
  ¦--output.R              
  ¦--output                
  ¦   ¦--fatage.csv        
  ¦   ¦--mohns_rho.csv     
  ¦   ¦--natage.csv        
  ¦   ¦--partab.csv        
  ¦   °--tab_summary.csv   
  ¦--report.R              
  ¦--report.Rmd            
  ¦--report                
  ¦   ¦--catage.csv        
  ¦   ¦--Fbar.png          
  ¦   ¦--Landings.png      
  ¦   ¦--Rec.png           
  ¦   ¦--retrospective.png 
  ¦   ¦--SSB.png           
  ¦   °--summary.png       
  ¦--report_doc.R          
  ¦--report_plots.R        
  °--report_tables.R       
```
