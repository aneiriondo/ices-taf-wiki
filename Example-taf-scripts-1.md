
See also: [Getting set up](Getting-set-up), [Running a TAF
analysis](Running-a-TAF-analysis), [Creating TAF
datasets](Creating-TAF-datasets).

This page was based on using the `icesTAF` package version `4.0.1` dated
`2022-09-07`.

This example requires a package to be installed that is not on CRAN.
Please ensure you have the package `stockasessment` by running

``` r
# Download and install stockassessment in R
install.packages("stockassessment", repos = "https://fishfollower.r-universe.dev")
```

The resulting TAF analysis created from this example is on GitHub:
[github.com/ices-taf-dev/wiki-example-3](https://github.com/ices-taf-dev/wiki-example-3),
if you dont want to build up the code yourself by following the example,
you can skip to the end and run on your computer by downloading the
complete code and running it like this:

``` r
# get code
run_dir <- download.analysis("ices-taf-dev/wiki-example-3")
# view downloaded code
browseURL(run_dir)

# run analysis
run.analysis(run_dir)
# view result
browseURL(run_dir)
```

## In this guide

  - [The excercise](#the-excercise)

## The excercise

In this example the aim is to convert the following simple code, taken
from the help file from the `trees` dataset (run `?trees` in R), into
the TAF structure.

``` r
# an example (very simple) analysis
# excercise is to move this into a TAF structure

# load data
data(trees)

# some plotting
pairs(trees, panel = panel.smooth, main = "trees data")
plot(Volume ~ Girth, data = trees, log = "xy")
coplot(log(Volume) ~ log(Girth) | Height,
  data = trees,
  panel = panel.smooth
)

# modeling and summarising

# model
fm1 <- lm(log(Volume) ~ log(Girth), data = trees)
fm2 <- update(fm1, ~ . + log(Height), data = trees)
step(fm2)

summary(fm1)
summary(fm2)
```

The steps you should follow are:

1.  Create a `DATA.bib` file
2.  Extract the code for the `data.R` section
3.  Extract the code for the `model.R` section
4.  Extract the code for the `output.R` section
5.  Extract the code for the `report.R` section

At each stage you can test with `taf.bootstrap()` and `sourceTAF()` as
appropriate, and finally check the whole thing runs by calling
`taf.bootsrap(taf=TRUE)` and `sourceAll()`
