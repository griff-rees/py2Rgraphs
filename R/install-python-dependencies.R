#' Placeholder for the python networkx package
#'
#' This provides a namespace placeholder for loading the python networkx library
networkx <- NULL

#' Install all needed python dependencies
#'
#' Install python dependencies not currently in the loaded in the current
#' reticulate python environment
#' @param method string passed to reticulate::py_install 'method' parameter
#' @param conda string passed to reticulate::py_install 'conda' parameter
install_dependencies <- function(method = "auto", conda = "auto") {
  if (!reticulate::py_module_available("networkx")) {
    reticulate::py_install("networkx", method = method, conda = conda)
  }
  if (!reticulate::py_module_available("pandas")) {
    reticulate::py_install("pandas", method = method, conda = conda)
  }
}
