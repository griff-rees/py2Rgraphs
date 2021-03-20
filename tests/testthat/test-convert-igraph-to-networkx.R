context("Convert an iGraph graph to a Networkx graph")

source("utils.R")

test_that("save an iGraph graph to a Networkx json", {
  skip_if_no_networkx()
  test_netx <- netx2igraph(test_json_fixture_path)

  igraph2json(test_netx, path = test_json_save_path)
  test_loaded_netx <- netx2igraph(test_json_save_path)

  expect_true(igraph::is_bipartite(test_loaded_netx))

  # Note: currently skipping the last two attributes
  # igraphID and igraphName which are added in the export process
  expect_equal(
    igraph::vertex_attr_names(test_netx),
    igraph::vertex_attr_names(test_loaded_netx)[1:5]
  )

  expect_equal(
    igraph::vcount(test_netx),
    igraph::vcount(test_loaded_netx)
  )
  expect_equal(
    igraph::ecount(test_netx),
    igraph::ecount(test_loaded_netx)
  )
  expect_equal(
    igraph::V(test_netx)$kind,
    igraph::V(test_loaded_netx)$kind
  )
  expect_equal(
    igraph::V(test_netx)$bipartite,
    igraph::V(test_loaded_netx)$bipartite
  )
  expect_equal(
    igraph::edge_attr_names(test_netx),
    igraph::edge_attr_names(test_loaded_netx)
  )
  expect_equal(
    igraph::as_edgelist(test_netx),
    igraph::as_edgelist(test_loaded_netx)
  )
  file.remove(test_json_save_path)
})
