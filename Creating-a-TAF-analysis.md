Creating a TAF analysis
=======================

Clone
-----

The first step is asking the ICES secratariate to create a repository
for your stock. In this example we will work with North Sea cod:
cod.27.47d20 in 2019 - the repository name for the assessment will be
cod.27.47d20. When a new repository is created on GitHub you should
clone the repository to your own computer. From here we will assume you
have cloned the

Make skeleton
-------------

The first step in creating a TAF analysis is to set out the basic folder
and file structure of the project. This is done using the function
[`taf.skeleton`](https://rdrr.io/cran/icesTAF/man/taf.skeleton.html).
which creates the following structure in your working directory

     cod.27.47d20    
      ¦--bootstrap   
      ¦   °--initial 
      ¦       °--data
      ¦--data.R      
      ¦--model.R     
      ¦--output.R    
      °--report.R
