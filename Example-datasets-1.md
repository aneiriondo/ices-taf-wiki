
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
  - [Adding a file from a URL](#adding-a-file-from-a-URL)
  - [Adding data via a bootstrap
    script](#adding-data-via-a-bootstrap-script)

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
  ¦   °--initial 
  ¦       °--data
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
  ¦   °--initial          
  ¦       °--data         
  ¦           °--trees.csv
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

    ## [09:53:05] Bootstrap procedure running...

    ## Processing DATA.bib

    ## [09:53:05] * trees.csv

    ## [09:53:05] Bootstrap procedure done

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

    ## [09:53:05] Bootstrap procedure running...

    ## Processing DATA.bib

    ## [09:53:05] * trees.csv

    ## [09:53:05] * my-collection

    ## [09:53:05] Bootstrap procedure done

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

## Adding a file from a URL

So far we have been importing local datasets and files, and so the
`bootstrap/initial/data` folder is identical to the `bootstrap/data`
folder, and you may be wondering, ‘what is the point?’. An important
purpose of this step is to add documentation to a dataset, to add
provenance, so that every dataset in `bootstrap/data` has a coresponding
record in `DATA.bib`.

But this step does not just copy files from one place to the other. It
can also fetch data and files from other locations. In this example, we
get a file from an URL, in this case, a raster file of sea surface
temperatures from the UK metoffice
[www.metoffice.gov.uk/hadobs/hadsst4/](https://www.metoffice.gov.uk/hadobs/hadsst4/),
and we can create the entry in the `DATA.bib` file, again using
`draft.data()`.

``` r
draft.data(
  data.files = "HadSST.4.0.1.0_median.nc",
  data.scripts = NULL,
  originator = "UK MET office",
  title = "Met Office Hadley Centre observations datasets",
  year = 2022,
  source = "https://www.metoffice.gov.uk/hadobs/hadsst4/data/netcdf/HadSST.4.0.1.0_median.nc",
  file = TRUE,
  append = TRUE
)
```

after running

``` r
taf.bootstrap()
```

    ## [09:53:05] Bootstrap procedure running...

    ## Processing DATA.bib

    ## [09:53:05] * trees.csv

    ## [09:53:05] * my-collection

    ## [09:53:05] * HadSST.4.0.1.0_median.nc

    ## [09:53:05] Bootstrap procedure done

your project should now look like this:

``` r
 example-1                           
  ¦--bootstrap                       
  ¦   ¦--DATA.bib                    
  ¦   ¦--data                        
  ¦   ¦   ¦--HadSST.4.0.1.0_median.nc
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

and you will have succesfully downloaded, documented and imported (via
running `taf.bootstrap()`) a dataset from a URL, and you will notice
that the `bootstrap/data` folder now contains more than what is in
`bootstrap/initial/data`.

## Adding data via a bootstrap script

Sometimes it is not possible to download a dataset from a single url,
and it requires multiple steps to fetch and process data from an online
source. This is common with data accessed via web services. In this
example we create a script where we write a short recipe of how to get
our data, and then register this in the `DATA.bib` file. Firstly you
need to write a script, and for this example the following code will do
that for you:

``` r
cat('library(icesTAF)
library(sf)

download(
  "http://gis.ices.dk/shapefiles/ICES_areas.zip"
)

unzip("ICES_areas.zip")
unlink("ICES_areas.zip")

areas <- st_read("ICES_Areas_20160601_cut_dense_3857.shp")

# write as csv
st_write(
  areas, "ices-areas.csv",
  layer_options = "GEOMETRY=AS_WKT"
)

unlink(dir(pattern = "ICES_Areas_20160601_cut_dense_3857"))
',
  file = "bootstrap/ices-areas.R"
)
```

bootsrap scripts such as this one, goes in the `bootstrap` folder,

``` r
 example-1                           
  ¦--bootstrap                       
  ¦   ¦--DATA.bib                    
  ¦   ¦--data                        
  ¦   ¦   ¦--HadSST.4.0.1.0_median.nc
  ¦   ¦   ¦--my-collection           
  ¦   ¦   ¦   ¦--cars.csv            
  ¦   ¦   ¦   °--trees.csv           
  ¦   ¦   °--trees.csv               
  ¦   ¦--ices-areas.R                
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

and are decsribed in more detail in [Bib entries](Bib-entries). We then
document it and add an entry to the `DATA.bib` file as before:

``` r
draft.data(
  data.files = NULL,
  data.scripts = "ices-areas.R",
  originator = "ICES",
  title = "ICES areas",
  file = TRUE,
  append = TRUE
)
```

and after running

``` r
taf.bootstrap()
```

    ## [09:53:06] Bootstrap procedure running...

    ## Processing DATA.bib

    ## [09:53:06] * trees.csv

    ## [09:53:06] * my-collection

    ## [09:53:06] * HadSST.4.0.1.0_median.nc

    ##   Skipping download of 'HadSST.4.0.1.0_median.nc' (already in place).

    ## [09:53:06] * ices-areas

    ## Linking to GEOS 3.9.1, GDAL 3.4.3, PROJ 7.2.1; sf_use_s2() is TRUE

    ## Reading layer `ICES_Areas_20160601_cut_dense_3857' from data source 
    ##   `D:\projects\git\ices-taf\other\doc.wiki\example-1\bootstrap\data\ices-areas\ICES_Areas_20160601_cut_dense_3857.shp' 
    ##   using driver `ESRI Shapefile'
    ## Simple feature collection with 66 features and 10 fields
    ## Geometry type: MULTIPOLYGON
    ## Dimension:     XY
    ## Bounding box:  xmin: -4898058 ymin: 4300621 xmax: 7625385 ymax: 30240970
    ## Projected CRS: WGS 84 / Pseudo-Mercator
    ## Writing layer `ices-areas' to data source `ices-areas.csv' using driver `CSV'
    ## options:        GEOMETRY=AS_WKT 
    ## Writing 66 features with 10 fields and geometry type Multi Polygon.

    ## [09:53:55] Bootstrap procedure done

your project should now look like this:

``` r
 example-1                           
  ¦--bootstrap                       
  ¦   ¦--DATA.bib                    
  ¦   ¦--data                        
  ¦   ¦   ¦--HadSST.4.0.1.0_median.nc
  ¦   ¦   ¦--ices-areas              
  ¦   ¦   ¦   ¦--DISCLAIMER_GIS.txt  
  ¦   ¦   ¦   °--ices-areas.csv      
  ¦   ¦   ¦--my-collection           
  ¦   ¦   ¦   ¦--cars.csv            
  ¦   ¦   ¦   °--trees.csv           
  ¦   ¦   °--trees.csv               
  ¦   ¦--ices-areas.R                
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

Now we have
