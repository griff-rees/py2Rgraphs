#' Convert networkx bipartite graph to igraph
#' 
#' This uses \code{networkx} and \code{pandas python libraries to convert
#' a \code{networkx} graph object to an R \code{igraph} object
#' 
#' @param path A path to the \code{networkx} json file to load.
#' @return An \code{igraph} object equivalent with all the components in
#'   \{path}.
#' @examples
#' add(1, 1)
#' add(10, 1)
#,
#' @rdname netx2igraph
#' @export
netx2igraph <- function(path) {
  networkx <- reticulate::import("networkx")
  netxio <- reticulate::import("networkxio")  # Refactor out

  netxgraph <- netxio$read_json_graph(path)
  netxnodes <- netxio$networkx2nodeattr(netxgraph)
  netxedges <- netxio$networkx2edgeattr(netxgraph)
  
  is_directed <- networkx$is_directed(netxgraph)
  rg <- igraph::graph_from_data_frame(netxedges,
                                      directed=is_directed,
                                      vertices=netxnodes)
  return(rg)
}

# networkx <- NULL
# pandas <- NULL

.onLoad <- function(libname, pkgname) {
  reticulate::configure_environment(pkgname)
  # networkx <<- reticulate::import("networkx", delay_load=TRUE)
}

# netx2pandas <-function(){
# 
# }
