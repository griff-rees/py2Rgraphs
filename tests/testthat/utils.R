skip_if_no_networkx <- function() {
  if (!reticulate::py_module_available("networkx")) {
    testthat::skip("networkx not available for testing")
  }
}

skip_if_no_pandas <- function() {
  if (!reticulate::py_module_available("pandas")) {
    testthat::skip("pandas not available for testing")
  }
}

test_json_fixture_path <- "test-networkx.json"
test_json_save_path <- "test-save.json"
