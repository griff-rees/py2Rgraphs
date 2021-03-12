skip_if_no_networkx <- function() {
  if (!reticulate::py_module_available("networkx"))
    skip("networkx not available for testing")
}

skip_if_no_pandas <- function() {
  if (!reticulate::py_module_available("pandas"))
    skip("pandas not available for testing")
}
