local({
  r = getOption("repos")
  r["CRAN"] = "https://cran.rstudio.com/"
  options(repos = r)
})

sshhh <- function(a.package){
  suppressWarnings(suppressPackageStartupMessages(
    library(a.package, character.only=TRUE)))
}

auto.loads <-c("colorout")

tryCatch({
    if (interactive()) {
      invisible(sapply(auto.loads, sshhh))
    }
}, error = function(e) {
    print("Some of the autoload libraries could not be loaded")
})

print("we are in here")
