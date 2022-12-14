
## In this guide

  - [Software to install](#software-to-install)
  - [R packages to install](#r-packages-to-install)
  - [Additional software to install](#additional-software-to-install)

## Software to install

The easiest way to set up your system is to install:

  - R: [cran.r-project.org/](https://cran.r-project.org/)
  - Rstudio:
    [www.rstudio.com/products/rstudio/download](https://www.rstudio.com/products/rstudio/download/#download)

## R packages to install

Once you have installed R (and RStudio) you can begin to install some R
packages. For TAF to work you need only one package: `icesTAF`. You
install this by running the line:

``` r
install.packages("icesTAF")
```

However, to run the code in this wiki, you need the development version,
which can be found here:

``` r
install.packages("icesTAF", repos = "https://ices-tools-prod.r-universe.dev")
```

## Additional software to install

If you wish to also use GitHub to version control your code, then you
also need to install:

  - Git: <https://git-scm.com/downloads>

And finally if you are using Windows, and you wish to install some
special R packages from GitHub you will need to install:

  - Rtools:
    [cran.r-project.org/bin/windows/Rtools](https://cran.r-project.org/bin/windows/Rtools/)
