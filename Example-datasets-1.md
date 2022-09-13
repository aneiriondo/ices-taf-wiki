
See also: [Creating TAF datasets](Creating-TAF-datasets), [Bib
entries](Bib-entries), [Example data records (bib
entries)](Example-data-records).

This page was based on using the `icesTAF` package version `4.0.0` dated
`2022-09-07`.

## In this guide

  - [Creating an empty TAF project](#creating-an-empty-TAF-project)
  - [Adding a local dataset](#adding-a-local-dataset)
  - [Adding a local collection of data
    files](#adding-a-local-collection-of-data-files)

## Creating an empty TAF project

First we create an empty TAF project, and in this case we will call it
`example-1`, and then moving our working directory to this folder. We do
this by running

``` r
taf.skeleton("example-1")
setwd("example-1")
```

resulting in the following:

``` r
 example-1                
  ¦--bootstrap            
  ¦   ¦--initial          
  ¦   ¦   °--data         
  ¦   ¦       °--trees.csv
  ¦   ¦--DATA.bib         
  ¦   °--data             
  ¦       °--trees.csv    
  ¦--data.R               
  ¦--model.R              
  ¦--output.R             
  °--report.R             
```

## Adding a local dataset

First lets save or copy a file from somewhere else on our computer and
put it into the `bootstrap\initial\data` folder. Remember, this is the
place where you can bring in files that you are unable to get from other
online sources, such as web services and urls.

In this example we will use a dataset that comes shipped with R called
`trees`, and save it as a csv file.

``` r
data(trees)
write.taf(trees, dir = "bootstrap/initial/data")
```

and now your project should look like this:

``` r
 example-1                
  ¦--bootstrap            
  ¦   ¦--initial          
  ¦   ¦   °--data         
  ¦   ¦       °--trees.csv
  ¦   ¦--DATA.bib         
  ¦   °--data             
  ¦       °--trees.csv    
  ¦--data.R               
  ¦--model.R              
  ¦--output.R             
  °--report.R             
```

The way TAF works, is that only data in `bootstrap/data` are allowed to
be used by the TAF scripts, and the way that the `bootstrap/data` folder
is populated is by creating entries in a file called `DATA.bib`, and
then running `taf.bootstrap()`.

We will create the `DATA.bib` file using the useful `draft.data()`
function, and as we do so, will add some useful information to document
the dataset we are importing:

``` r
draft.data(
  data.files = "trees.csv",
  data.scripts = NULL,
  originator = "Ryan, T. A., Joiner, B. L. and Ryan, B. F. (1976) The Minitab Student Handbook. Duxbury Press.",
  title = "Diameter, Height and Volume for Black Cherry Trees",
  file = TRUE,
  append = FALSE # create a new DATA.bib
)
```

after running

``` r
taf.bootstrap()
```

    ## [09:22:27] Bootstrap procedure running...

    ## Processing DATA.bib

    ## [09:22:27] * trees.csv

    ## [09:22:27] Bootstrap procedure done

your project should now look like this:

``` r
 example-1                
  ¦--bootstrap            
  ¦   ¦--DATA.bib         
  ¦   ¦--data             
  ¦   ¦   °--trees.csv    
  ¦   °--initial          
  ¦       °--data         
  ¦           °--trees.csv
  ¦--data.R               
  ¦--model.R              
  ¦--output.R             
  °--report.R             
```

and you will have succesfully save, documented and imported (via running
`taf.bootstrap()`) a local dataset into your project.

## Adding a local collection of data files

In this example, we will add another dataset, but this time it will be a
folder containing several files. You can create this yourself however
you like, but the following code will create an example for you

``` r
data(trees)
data(cars)
# make the directory we want to write to
mkdir("bootstrap/initial/data/my-collection")
# save files there
write.taf(trees, dir = "bootstrap/initial/data/my-collection")
write.taf(cars, dir = "bootstrap/initial/data/my-collection")
```

and now your project should look like this:

``` r
 example-1                    
  ¦--bootstrap                
  ¦   ¦--DATA.bib             
  ¦   ¦--data                 
  ¦   ¦   °--trees.csv        
  ¦   °--initial              
  ¦       °--data             
  ¦           ¦--my-collection
  ¦           ¦   ¦--cars.csv 
  ¦           ¦   °--trees.csv
  ¦           °--trees.csv    
  ¦--data.R                   
  ¦--model.R                  
  ¦--output.R                 
  °--report.R                 
```

Again we document this using `draft.data()` to add it to the `DATA.bib`
file, but this time there are two differences:

1.  We are adding a new record, so we set `append = TRUE` as we want to
    add a record to an existing list of records.
2.  We are adding a folder, so we set `source = "folder"`

<!-- end list -->

``` r
draft.data(
  data.files = "my-collection",
  data.scripts = NULL,
  originator = "R datasets package",
  title = "Collection of R data",
  source = "folder",
  file = TRUE,
  append = TRUE # create a new DATA.bib
)
```

after running

``` r
taf.bootstrap()
```

    ## [09:22:27] Bootstrap procedure running...

    ## Processing DATA.bib

    ## [09:22:27] * trees.csv

    ## [09:22:27] * my-collection

    ## [09:22:27] Bootstrap procedure done

your project should now look like this:

``` r
 example-1                    
  ¦--bootstrap                
  ¦   ¦--DATA.bib             
  ¦   ¦--data                 
  ¦   ¦   ¦--my-collection    
  ¦   ¦   ¦   ¦--cars.csv     
  ¦   ¦   ¦   °--trees.csv    
  ¦   ¦   °--trees.csv        
  ¦   °--initial              
  ¦       °--data             
  ¦           ¦--my-collection
  ¦           ¦   ¦--cars.csv 
  ¦           ¦   °--trees.csv
  ¦           °--trees.csv    
  ¦--data.R                   
  ¦--model.R                  
  ¦--output.R                 
  °--report.R                 
```

and you will have succesfully save, documented and imported (via running
`taf.bootstrap()`) a local dataset, and a local collection of data files
into your project.
