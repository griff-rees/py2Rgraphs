#' Placeholder for the python networkx package
#'
#' This provides a namespace placeholder for loading the python networkx library
networkx <- NULL

#' Install the python networkx library
#'
#' This is an option for installing networkx if it isn't added automatically
#' @param method string passed to reticulate::py_install 'method' parameter
#' @param conda string passed to reticulate::py_install 'conda' parameter
install_networkx <- function(method = "auto", conda = "auto") {
  reticulate::py_install("networkx", method = method, conda = conda)
}

#' Placeholder for the python pandas package
#'
#' This provides a namespace placeholder for loading the python pandas library
pandas <- NULL

#' Install the python pandas library
#'
#' This is an option for installing pandas if it isn't added automatically
#' @param method string passed to reticulate::py_install 'method' parameter
#' @param conda string passed to reticulate::py_install 'conda' parameter
install_pandas <- function(method = "auto", conda = "auto") {
  reticulate::py_install("pandas", method = method, conda = conda)
}


#' Install all needed python dependencies
#'
#' Install python dependencies not currently in the loaded in the current
#' reticulate python environment
install_dependencies <- function() {
  if (!reticulate::py_module_available("networkx")) {
    install_networkx()
  }
  if (!reticulate::py_module_available("pandas")) {
    install_pandas()
  }
}
