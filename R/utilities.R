library(data.tree)
library(icesTAF)

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
  sprintf("[`%1$s`](https://rdrr.io/cran/icesTAF/man/%1$s.html)", x)
}
