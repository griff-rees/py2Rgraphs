#' Convert networkx graph to an igraph Graph
#'
#' This uses \code{networkx} and \code{pandas} python libraries to convert
#' a \code{networkx} graph object to an R \code{igraph} object, including
#' whether the graph is bipartite.
#'
#' @param path A path to a \code{networkx} json file to load.
#' @return An \code{igraph} object equivalent with all the components in
#'   \code{path}.
#' @examples
#' library(igraph)
#' board_network <- netx2igraph("path/to/networkx/board-network.json")
#' vcount(board_network)
#' @rdname netx2igraph
#' @export
netx2igraph <- function(path) {
  if (!reticulate::py_module_available("networkx")) {
    warning("Python module 'networkx' not available, returning NULL")
    return(NULL)
  }

  if (!reticulate::py_module_available("pandas")) {
    warning("Python module 'pandas' not available, returning NULL")
    return(NULL)
  }

  netxgraph <- netxio$read_json_graph(path)
  netxnodes <- netxio$networkx2nodeattr(netxgraph)
  netxedges <- netxio$networkx2edgeattr(netxgraph)

  is_directed <- networkx$is_directed(netxgraph)
  rg <- igraph::graph_from_data_frame(netxedges,
    directed = is_directed,
    vertices = netxnodes
  )
  if (networkx$is_bipartite(netxgraph)) {
    igraph::V(rg)$type <- igraph::V(rg)$bipartite
  }
  return(rg)
}
