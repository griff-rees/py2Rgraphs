context("Loading and converting Networkx json")

source("utils.R")

test_that("basic NetworkX JSON converts to igraph Network object", {
  skip_if_no_networkx()
  skip_if_no_pandas()
  testIgraph <-py2Rgraphs::netx2igraph("test-networkx.json")
  expect_equal(igraph::vcount(testIgraph), 20)
  expect_equal(igraph::ecount(testIgraph), 19)
  expect_true(igraph::is_bipartite(testIgraph))
})
