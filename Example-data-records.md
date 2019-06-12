
This page was based on using the `icesTAF` package version `3.1.1` dated
`2019-05-24`.

## In this guide

  - [Using a script to download a zip
    file](#Using-a-script-to-download-a-zip-file)

We will start with an empty repository

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

## Using a script to download a zip file

Consider the following script that downloads a zip file containing ESRI
shapefiles of ICES areas, unzips it and deletes the zip file

``` r
filename <- "ICES_areas.zip"
# download and unzip
download(paste0("http://gis.ices.dk/shapefiles/", filename))
unzip(filename)
# delete zip file
unlink(filename)
```

This code can be used to download shapefiles for use in a TAF assessment
by specifying `script` as the `source` of the data. This is done by
creating the following meta-data record in `DATA.bib`

``` r
@Misc{icesareas,
  originator = {ICES},
  year       = {2019},
  title      = {ICES Areas ESRI Shapefile},
  period     = {},
  source     = {script},
}
```

and an accompaning R script. The R script must have the same name as the
‘key’ feild. In this case the key is `icesareas` so the script must be
called `icesareas.R`. The `DATA.bib` entry can be created using the
[`draft.data`](https://rdrr.io/cran/icesTAF/man/draft.data.html)
function

``` r
  draft.data(data.files = "icesareas",
             originator = "ICES", 
             title = "ICES Areas ESRI Shapefile",
             source = "script",
           file = "bootstrap/DATA.bib")
```

after you have created the script in the bootstrap folder called
`icesareas.R` the directory structure should look like this:

``` r
 cod.27.47d20       
  ¦--bootstrap      
  ¦   ¦--DATA.bib   
  ¦   °--icesareas.R
  ¦--data.R         
  ¦--model.R        
  ¦--output.R       
  °--report.R       
```

Now we can run
[`taf.bootstrap`](https://rdrr.io/cran/icesTAF/man/taf.bootstrap.html)
to process the script to download the process the zip file and now the
directory structyre will look like this

``` r
taf.bootstrap()
```

``` r
 cod.27.47d20                                              
  ¦--bootstrap                                             
  ¦   ¦--DATA.bib                                          
  ¦   ¦--data                                              
  ¦   ¦   °--icesareas                                     
  ¦   ¦       ¦--ICES_Areas_20160601_cut_dense_3857.cpg    
  ¦   ¦       ¦--ICES_Areas_20160601_cut_dense_3857.dbf    
  ¦   ¦       ¦--ICES_Areas_20160601_cut_dense_3857.prj    
  ¦   ¦       ¦--ICES_Areas_20160601_cut_dense_3857.sbn    
  ¦   ¦       ¦--ICES_Areas_20160601_cut_dense_3857.sbx    
  ¦   ¦       ¦--ICES_Areas_20160601_cut_dense_3857.shp    
  ¦   ¦       ¦--ICES_Areas_20160601_cut_dense_3857.shp.xml
  ¦   ¦       °--ICES_Areas_20160601_cut_dense_3857.shx    
  ¦   °--icesareas.R                                       
  ¦--data.R                                                
  ¦--model.R                                               
  ¦--output.R                                              
  °--report.R                                              
```
