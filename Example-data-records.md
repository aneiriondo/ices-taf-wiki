
This page was based on using the `icesTAF` package version `3.1.1` dated
`2019-05-24`.

## In this guide

  - [Using a script to download a zip
    file](#Using-a-script-to-download-a-zip-file)
  - [Get the ICES word template](#Get-the-ICES-word-template)
  - [Further `DATA.bib` entries](#Further-DATA.bib-entries)

## Using a script to download a zip file

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

## Get the ICES word template

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

To download this file for use in an automated report for a TAF
assessment, specify the location of the file as the `source` of the data
record. The file is held in the
[ices-taf/doc](https://github.com/ices-taf/doc) repository and is called
reportTemplate.docx. This is done by creating the following meta-data
record in `DATA.bib`

``` r
@Misc{reportTemplate.docx,
  originator = {ICES},
  year       = {2019},
  title      = {ICES TAF word template for report automation},
  period     = {},
  source     = {https://github.com/ices-taf/doc/raw/master/reportTemplate.docx},
}
```

The `DATA.bib` entry can be created using the
[`draft.data`](https://rdrr.io/cran/icesTAF/man/draft.data.html)
function

``` r
  draft.data(data.files = "reportTemplate.docx",
             originator = "ICES",
             title = "ICES TAF word template for report automation",
             source = "https://github.com/ices-taf/doc/raw/master/reportTemplate.docx",
             file = "bootstrap/DATA.bib")
```

The directory structure should now look like this:

``` r
 cod.27.47d20    
  ¦--bootstrap   
  ¦   °--DATA.bib
  ¦--data.R      
  ¦--model.R     
  ¦--output.R    
  °--report.R    
```

Now we can run
[`taf.bootstrap`](https://rdrr.io/cran/icesTAF/man/taf.bootstrap.html)
to process the script to download the word template file and now the
directory structyre will look like this

``` r
taf.bootstrap()
```

``` r
 cod.27.47d20                   
  ¦--bootstrap                  
  ¦   ¦--DATA.bib               
  ¦   °--data                   
  ¦       °--reportTemplate.docx
  ¦--data.R                     
  ¦--model.R                    
  ¦--output.R                   
  °--report.R                   
```

## Further `DATA.bib` entries

#### ICES Statistical Rectangles mapped to Ecoregions

`DATA.bib` entry:

``` r
@Misc{ICES_StatRec_mapto_Ecoregions,
  originator = {DTU Aqua},
  year       = {2019},
  title      = {ICES Stat rec ESRI Shapefile},
  period     = {},
  source     = {script},
  url        = {https://gis.ices.dk/geonetwork/srv/metadata/81f68a99-9b91-4762-80d3-31c069731f44}
}
```

with the R script: `ICES_StatRec_mapto_Ecoregions.R`

``` r
filename <- "ICES_StatRec_mapto_Ecoregions.zip"
# download and unzip
download(paste0("http://gis.ices.dk/shapefiles/", filename))
unzip(filename)
# delete zip file
unlink(filename)
```

### ICES Ecoregion

`DATA.bib` entry:

``` r
@Misc{ICES_ecoregions,
  originator = {ICES},
  year       = {2019},
  title      = {ICES Ecoregion ESRI Shapefile},
  period     = {},
  source     = {script},
  url        = {https://gis.ices.dk/geonetwork/srv/metadata/4745e824-a612-4a1f-bc56-b540772166eb}
}
```

with the r script: `ICES_ecoregions.R`

``` r
filename <- "ICES_ecoregions.zip"
# download and unzip
download(paste0("http://gis.ices.dk/shapefiles/", filename))
unzip(filename)
# delete zip file
unlink(filename)
```

### Species lookup table from ICES SD database

`DATA.bib` entry:

``` bibtex
@Misc{ICES_SD_species_lookup,
  originator = {ICES},
  year       = {2019},
  title      = {ICES Fisheries Guild lookup table},
  period     = {},
  source     = {script},
  url        = {https://gis.ices.dk/geonetwork/srv/metadata/30541cf4-0236-437f-9757-596c5f793cff}
}
```

with the R script: `ICES_SD_species_lookup.R`

``` r
library(icesSD)

sid <- getSD()

# get lookup table for species, common name and Fisheries guild from SID
species_lookup <- 
  sid %>%
  filter(ActiveYear > 2018) %>%
  select(SpeciesScientificName, SpeciesCommonName, FisheriesGuild) %>%
  mutate(FisheriesGuild = tolower(FisheriesGuild)) %>%
  filter(!is.na(FisheriesGuild) & !is.na(SpeciesScientificName)) %>%
  unique

write.taf(species_lookup, quote = TRUE)
```
