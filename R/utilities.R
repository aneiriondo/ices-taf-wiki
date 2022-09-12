library(data.tree)
library(icesTAF)
library(icesTAFWeb)

repoName <- "cod.27.47d20"

if (dir.exists(repoName)) {
  unlink(repoName, recursive = TRUE)
}

formatCode <- function(x, language = "r") {
  c(
    sprintf("\`\`\`%s", language),
    x,
    "\`\`\`"
  )
}

printDir <- function(paths = NULL) {
  if (is.null(paths)) {
    # get skeleton path structure
    paths <- dir(repoName, full.names = TRUE, recursive = TRUE)
  }

  # make a data.tree and print it
  tree <- as.Node(data.frame(pathString = paths))
  res <-
    capture.output(
      print(
        as.data.frame(tree),
        row.names = FALSE
      )
    )
  cat(formatCode(res[-1]), sep = "\n")
}

taflink <- function(x) {
  cranlink("icesTAF", x)
}

cranlink <- function(package, FUNC) {
  sprintf(
    "[`%2$s`](https://rdrr.io/cran/%1$s/man/%2$s.html)",
    package,
    FUNC
  )
}

# repo <- "ices-taf/2019_san.sa.6"
download.analysis <- function(repo, dir = tempdir()) {
  
  branches <- c("main", "master")
  
  zip_urls <-
    paste0(
      "https://github.com/", repo, "/archive/refs/heads/",
      branches, ".zip"
    )
  destfile <-
    paste0(
      file.path(dir, basename(repo)), 
      format(Sys.time(), "-%Y%m%d-%H%M%S"), 
      ".zip"
    )
  
  for (zip_url in zip_urls) {  
    res <-
      try(
        suppressWarnings(
          download.file(zip_url, destfile = destfile)
        ), 
        silent = TRUE
      )
    if (!inherits(res, "try-error")) cycle
  }
  
  files <- unzip(destfile, list = TRUE)
  zipdir <- gsub("/", "", files$Name[1])
  files <- files[files$Length > 0,]
  
  files_to_get <-
    c(
      grep("*[.]R", files$Name, value = TRUE),
      grep("*/bootstrap/initial/*", files$Name, value = TRUE),
      grep("*[.]bib", files$Name, value = TRUE)
    )
  
  unzip(destfile, exdir = dir, files = files_to_get)
  
  outdir <- file_path_sans_ext(destfile)
  
  dir.create(outdir)
  cp(file.path(dir, zipdir, "*"), outdir)
  # clean up?
  unlink(destfile)
  unlink(zipdir, recursive = TRUE)

  message("repo: ", repo, " has been downloaded to: ", dir)
  outdir  
}

run.analysis <- function(dir) {
  # install packages
  install.deps(dir)
  # run
  oldwd <- setwd(dir)
  taf.bootstrap()
  sourceAll()
  setwd(oldwd)
  
  message("Taf analysis in directory: ", dir, " has been run.")
  invisible()
}
