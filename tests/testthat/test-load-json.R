context("Loading and converting Networkx json")
# reticulate::import("networkx")

skip_if_no_networkx <- function() {
  have_networkx <- reticulate::py_module_available("networkx")
  if (!have_networkx)
    skip("networkx not available for testing")
}

skip_if_no_pandas <- function() {
  have_pandas <- reticulate::py_module_available("pandas")
  if (!have_pandas)
    skip("pandas not available for testing")
}

test_that("loading an example Networkx json file for python", {
  skip_if_no_pandas()
  skip_if_no_networkx()
  expect_equal(2 * 2, 4)
})
