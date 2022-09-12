
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
choose the current working directory that your R sessions is running in
(see `getwd()` to find out what this is).

``` r
run_dir <- download.analysis("ices-taf/2019_san.sa.6", dir = ".")
```

which results in the following files the directory created by the above
function:

``` r
 .                                                   
  °--2019_san.sa.6-20220912-135833                   
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

There are three steps to running a TAF analysis. 1. install all relavant
packages: `install.deps()` 2. run the data and software boot procedure:
`taf.bootstrap()` 3. run the TAF analysis scripts: `sourceAll()`
