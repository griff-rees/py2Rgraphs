# Convert networkx bipartite graph to igraph
#
# This uses networkx and pandas python libraries to convert
# a networkx graph object to an igraph object

.onLoad <- function(libname, pkgname) {
  reticulate::configure_environment(pkgname)
}

loadnetx <- function(path) {
  reticulate::py_run_string(
    "import networkx"
  )
  reticulate::py_run_string(
    "import json"
  )
  return(reticulate::py_run_string(
  "with open(path) as graph_file: return node_link_graph(load(graph_file))"
  ))
}

netx2pandas <-function(){

}

netx2igraph <- function(path) {
}
