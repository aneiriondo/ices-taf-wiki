
See also: [Creating a TAF analysis](Creating-a-TAF-analysis).

This page was based on using the `icesTAF` package version `4.0.0` dated
`2022-09-07`.

## In this guide

  - [Finding a TAF analysis](#finding-a-taf-analysis)

## Finding an analysis

The first step is finding a TAF analysis that you want to run. All TAF
stock assessments are made available on the [TAF web
application](https://taf.ices.dk/app/about) (see screenshot below).
There are publicly avilable analyses and private ones. Private analyses
have not yet been made publicly available and require to be reviewed.
Public analyses are accessed by clicking the “see publlic demo” button,
and private analyses are accessed by clicking the “Manage stock
assessments” button - this is only available to logged in users of the
ICES network and specifically to members of ICES stock assessment
working groups.

[![taf application
screenshot](img/taf-app.png)](https://taf.ices.dk/app/about)

In the following example we will select the 2019 sandeel in area 6
assessment, and the application gives a link to the github repository
for the code as
[`github.com/ices-taf/2019_san.sa.6`](https://github.com/ices-taf/2019_san.sa.6).
as seen below:

[![taf application (sandeel)
screenshot](img/taf-app-sandeel.png)](https://taf.ices.dk/app/demo#!/2019/san.sa.6)

## Getting the code

From the previous section we have found the github address of the code
we want to run, however we only need the name of the repository which
is: `ices-taf/2019_san.sa.6`. The following code will download the code
into a directory that you specify, otherwise it will download into a
temporary directory on your computer (default). In this case we will
choose the current working directory (specified by `"."`) that your R
sessions is running in (see `getwd()` to find out what this is).

``` r
run_dir <- download.analysis("ices-taf/2019_san.sa.6", dir = ".")
```

    ## repo: ices-taf/2019_san.sa.6 has been downloaded to: .

which results in the following files and directories:

``` r
 .                                                   
  °--2019_san.sa.6-20220912-145808                   
      ¦--bootstrap                                   
      ¦   ¦--DATA.bib                                
      ¦   °--initial                                 
      ¦       °--data                                
      ¦           °--sandeel_assessment_1982_2018.csv
      ¦--data.R                                      
      ¦--output.R                                    
      ¦--report.R                                    
      ¦--report.Rmd                                  
      ¦--report_doc.R                                
      ¦--report_plots.R                              
      ¦--report_tables.R                             
      °--utilities.R                                 
```

## Running the code

There are three steps to running a TAF analysis. All these steps are
contained in the function `run.analysis()`, but for the sake of
explaition, we will present each in turn, before showing the two lines
of code you need to run in the Rounding up section.

1.  install all relavant packages: `install.deps()`
2.  run the data and software boot procedure: `taf.bootstrap()`
3.  run the TAF analysis scripts: `sourceAll()`

### 1\. install all relavant packages: `install.deps()`

Some analyses may use R packages that are widely available but that you
do not have installed on your own computer. The `deps()` function
provides a list of packages used in an analysis, for example in the
example we are working with we have:

``` r
deps(run_dir)
```

    ## [1] "dplyr"     "ggplot2"   "htmlTable" "icesSAG"   "icesTAF"   "rmarkdown" "tidyr"

and the following function installs all of those packages that you do
not have installed

``` r
install.deps()
```

### 2\. run the data and software boot procedure: `taf.bootstrap()`

the next step is to run `taf.bootstrap()`. But before we do this we need
to set the working direcory to the location of the TAF scripts. Note
here that the function `setwd()` returns the current working directory
so we can return to where we were when we are finished.

``` r
oldwd <- setwd(run_dir)
taf.bootstrap()
```

    ## [14:58:10] Bootstrap procedure running...

    ## Processing DATA.bib

    ## [14:58:10] * reportTemplate.docx

    ## [14:58:10] * sandeel_assessment_1982_2018.csv

    ## [14:58:10] Bootstrap procedure done

``` r
setwd(oldwd)
```

which gathers data and software specified in the `DATA.bib` and
`SOFTWARE.bib` files, and results in the following

``` r
 .                                                   
  °--2019_san.sa.6-20220912-145808                   
      ¦--bootstrap                                   
      ¦   ¦--DATA.bib                                
      ¦   ¦--data                                    
      ¦   ¦   ¦--reportTemplate.docx                 
      ¦   ¦   °--sandeel_assessment_1982_2018.csv    
      ¦   °--initial                                 
      ¦       °--data                                
      ¦           °--sandeel_assessment_1982_2018.csv
      ¦--data.R                                      
      ¦--output.R                                    
      ¦--report.R                                    
      ¦--report.Rmd                                  
      ¦--report_doc.R                                
      ¦--report_plots.R                              
      ¦--report_tables.R                             
      °--utilities.R                                 
```

notice that there is a new folder `bootstrap/data` which contains files
that can now be used by the TAF analysis scripts in the next section.

### 3\. run the TAF analysis scripts: `sourceAll()`

The final step is to run `sourceAll()`, which runs, in sequence, the
`data.R`, `model.R`, `output.R` and `report.R` scripts.

``` r
oldwd <- setwd(run_dir)
sourceAll()
```

    ## Warning in write.taf(sag_info, dir = "output"): duplicated column names

    ##   |                                                                                                      |                                                                                              |   0%  |                                                                                                      |.......                                                                                       |   7%
    ##   ordinary text without R code
    ## 
    ##   |                                                                                                      |.............                                                                                 |  14%
    ## label: libraries (with options) 
    ## List of 1
    ##  $ include: logi FALSE
    ## 
    ##   |                                                                                                      |....................                                                                          |  21%
    ##   ordinary text without R code
    ## 
    ##   |                                                                                                      |...........................                                                                   |  29%
    ## label: chunk_setup (with options) 
    ## List of 1
    ##  $ include: logi FALSE
    ## 
    ##   |                                                                                                      |..................................                                                            |  36%
    ##   ordinary text without R code
    ## 
    ##   |                                                                                                      |........................................                                                      |  43%
    ## label: pander_settings (with options) 
    ## List of 1
    ##  $ include: logi FALSE
    ## 
    ##   |                                                                                                      |...............................................                                               |  50%
    ##   ordinary text without R code
    ## 
    ##   |                                                                                                      |......................................................                                        |  57%
    ## label: caption_counters (with options) 
    ## List of 1
    ##  $ include: logi FALSE
    ## 
    ##   |                                                                                                      |............................................................                                  |  64%
    ##    inline R code fragments
    ## 
    ##   |                                                                                                      |...................................................................                           |  71%
    ## label: catch_table
    ##   |                                                                                                      |..........................................................................                    |  79%
    ##   ordinary text without R code
    ## 
    ##   |                                                                                                      |.................................................................................             |  86%
    ## label: catch_plot (with options) 
    ## List of 2
    ##  $ fig.cap : symbol cap_in
    ##  $ fig.path: chr "report/summary.png"
    ## 
    ##   |                                                                                                      |.......................................................................................       |  93%
    ##   ordinary text without R code
    ## 
    ##   |                                                                                                      |..............................................................................................| 100%
    ## label: catch_plot2 (with options) 
    ## List of 2
    ##  $ fig.cap : symbol cap_in
    ##  $ fig.path: chr "report/summary.png"
    ## 
    ## 
    ## "C:/Users/colin/AppData/Local/CONTIN~1/MINICO~1/Library/bin/pandoc" +RTS -K512m -RTS report.knit.md --to docx --from markdown+autolink_bare_uris+tex_math_single_backslash --output report.docx --lua-filter "D:\R\win-library\4.2\rmarkdown\rmarkdown\lua\pagebreak.lua" --table-of-contents --toc-depth 3 --highlight-style tango --reference-doc "bootstrap\data\reportTemplate.docx"

``` r
setwd(oldwd)
```

and gives us the complete output from the TAF analyses.

``` r
 .                                                   
  °--2019_san.sa.6-20220912-145808                   
      ¦--bootstrap                                   
      ¦   ¦--DATA.bib                                
      ¦   ¦--data                                    
      ¦   ¦   ¦--reportTemplate.docx                 
      ¦   ¦   °--sandeel_assessment_1982_2018.csv    
      ¦   °--initial                                 
      ¦       °--data                                
      ¦           °--sandeel_assessment_1982_2018.csv
      ¦--data.R                                      
      ¦--data                                        
      ¦   °--summary_catch.csv                       
      ¦--output.R                                    
      ¦--output                                      
      ¦   ¦--sag_fishdata.csv                        
      ¦   ¦--sag_info.csv                            
      ¦   °--sag_upload.xml                          
      ¦--report.R                                    
      ¦--report.Rmd                                  
      ¦--report                                      
      ¦   ¦--catches_by_halfyear_bar.png             
      ¦   ¦--catches_by_halfyear_stack.png           
      ¦   ¦--report.docx                             
      ¦   ¦--summary_catch.csv                       
      ¦   ¦--summary_catch.html                      
      ¦   °--summary_catch.png                       
      ¦--report_doc.R                                
      ¦--report_plots.R                              
      ¦--report_tables.R                             
      °--utilities.R                                 
```

## Rounding up

The files in the TAF analyses we have just run should the same as on the
[TAF web application
page](https://taf.ices.dk/app/demo#!/2019/san.sa.6). Differences can
occur in some more complicated analyses, and this is to be expected with
differences in software between different machines.

All together, to get and run a TAF analysis stored on a GitHub
reposuitory, run the following lines of code in R:

``` r
# get code
run_dir <- download.analysis("ices-taf/2019_san.sa.6", dir = ".")
# run analysis
run.analysis(run_dir)
```
