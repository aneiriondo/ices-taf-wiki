
See also: [Bib entries](Bib-entries), [Example data
records](Example-data-records).

This page was based on using the `icesTAF` package version `4.0.0` dated
`2022-09-07`.

## In this guide

  - [Clone](#clone)
  - [Make Skeleton](#make-skeleton)
  - [Upload initial data](#upload-initial-data)
      - [Upload files](#upload-files)
      - [Make data available](#make-data-available-to-assessment)

## Clone

The first step is asking the ICES secratariat to create a repository for
your stock. In this example we will work with North Sea cod:
cod.27.47d20 in 2019 - the repository name for the assessment will be
cod.27.47d20. When a new repository is created on GitHub you should
clone the repository to your own computer. From here we will assume you
have cloned the repository.

## Make skeleton

The first step in creating a TAF analysis is to set out the basic folder
and file structure of the project. This is done using the function
[`taf.skeleton`](https://rdrr.io/cran/icesTAF/man/taf.skeleton.html),
which creates the following structure in your working directory

``` r
 cod.27.47d20    
  ¦--bootstrap   
  ¦   °--initial 
  ¦       °--data
  ¦--data.R      
  ¦--model.R     
  ¦--output.R    
  °--report.R    
```

## Upload initial data

The next step is to set up the data requirements for your assessment.
There are three ways to get data into an assessment: (1) upload files
directly, (2) get a file from the web, and (3) use R code to access a
web service. We will cover 1 and 2 here. See [Example data
records](Example-data-records) for more information.

### Upload files

To upload a file called `catch.csv` - the contents might be something
like:

    year,catches
    2015,2109
    2016,3455
    2017,3466
    2018,2050

Simply copy the file in to the `bootstrap/initial/data` folder. The
directory structure will now look like this:

``` r
 cod.27.47d20             
  ¦--bootstrap            
  ¦   °--initial          
  ¦       °--data         
  ¦           °--catch.csv
  ¦--data.R               
  ¦--model.R              
  ¦--output.R             
  °--report.R             
```

### Make data available to assessment

So far we have uploaded data into the intial data folder, but to make it
available to the assessment it needs to be in the `bootstrap/data`
folder, and the only way to do this is to create a file reference and
then run the function
[`taf.bootstrap`](https://rdrr.io/cran/icesTAF/man/taf.bootstrap.html).
To reference the data we create a file called `DATA.bib` using the
helper function
[`draft.data`](https://rdrr.io/cran/icesTAF/man/draft.data.html), and
add a few fields:

``` r
draft.data(
  originator = "WGNSSK",
  year = 2019,
  title = "Catch data for cod.27.347d",
  period = "2015-2018"
)
```

    ## @Misc{catch.csv,
    ##   originator = {WGNSSK},
    ##   year       = {2019},
    ##   title      = {Catch data for cod.27.347d},
    ##   period     = {2015-2018},
    ##   access     = {Public},
    ##   source     = {file},
    ## }

Then we write this to the `DATA.bib` file by specifying `file = TRUE`:

``` r
draft.data(
  originator = "WGNSSK",
  year = 2019,
  title = "Catch data for cod.27.347d",
  period = "2015-2018",
  file = TRUE
)
```

Finally we run `taf.bootstrap()` to get the data into the
`bootstrap/data` folder, leaving the directory tree looking like this:

``` r
 cod.27.47d20             
  ¦--bootstrap            
  ¦   ¦--DATA.bib         
  ¦   ¦--data             
  ¦   ¦   °--catch.csv    
  ¦   °--initial          
  ¦       °--data         
  ¦           °--catch.csv
  ¦--data.R               
  ¦--model.R              
  ¦--output.R             
  °--report.R             
```
