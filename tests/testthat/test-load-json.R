context("Loading and converting Networkx json")

source("utils.R")

test_that("basic NetworkX JSON converts to igraph Network object", {
  skip_if_no_networkx()
  skip_if_no_pandas()
  test_igraph <- py2Rgraphs::netx2igraph(test_json_fixture_path)
  expect_equal(igraph::vcount(test_igraph), 20)
  expect_equal(igraph::ecount(test_igraph), 19)
  expect_true(igraph::is_bipartite(test_igraph))
})
