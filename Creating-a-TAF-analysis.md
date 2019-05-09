Creating a TAF analysis
=======================

The first step in creating a TAF analysis is to set out the basic folder
and file structure of the project. This is done using the function
[`taf.skeleton`](https://rdrr.io/cran/icesTAF/man/taf.skeleton.html)
which creates the following structure in your working directory

    icesTAF::taf.skeleton("test")
    paths <- dir("test", full.names = TRUE, recursive = TRUE)
    paths <- c("test/bootstrap/initial/data/", paths)
    data.tree::as.Node(data.frame(pathString = paths))

    ## Registered S3 methods overwritten by 'ggplot2':
    ##   method         from 
    ##   [.quosures     rlang
    ##   c.quosures     rlang
    ##   print.quosures rlang

         levelName

1 test  
2 ¦–bootstrap  
3 ¦ °–initial 4 ¦ °–data 5 ¦–data.R  
6 ¦–model.R  
7 ¦–output.R  
8 °–report.R
