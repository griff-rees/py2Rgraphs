#' Convert igraph network to networkx Graph
#'
#' Convert \code{igraph} network to a \code{networkx} python object
#' including Vertex and Edge attributes and adding \code{igraph_id}
#' and \code{igraph_name} to retain \code{igraph} indexing
#'
#' @param r_igraph An \code{igraph} \code{graph} object
#' @param path An file \code{path} to save to \code{Networkx} \code{json} format
#' @examples \dontrun{
#' example_bi_modal_graph <- igraph::sample_bipartite(4, 5, p = .5)
#' igraph2json(example_bi_modal_graph, "test.json")
#' loaded_bi_modal_graph <- netx2igraph("test.json")
#' as_edgelist(example_bi_modal_graph) == as_edgelist(loaded_bi_modal_graph)
#' }
#' @rdname igraph2json
#' @export
igraph2json <- function(r_igraph, path) {
  if (!igraph::is_igraph(r_igraph)) {
    warning("Can only convert an igraph object, returning NULL")
    return(NULL)
  }

  if (!reticulate::py_module_available("networkx")) {
    warning("Python module 'networkx' not available, returning NULL")
    return(NULL)
  }

  if (!reticulate::py_module_available("pandas")) {
    warning("Python module 'pandas' not available, returning NULL")
    return(NULL)
  }

  if (igraph::is_bipartite(r_igraph)) {
    igraph::V(r_igraph)$bipartite <- igraph::V(r_igraph)$type
  }

  r_igraph_nodes <- igraph::as_data_frame(r_igraph, "vertices")
  r_igraph_nodes$igraph_id <- 1:igraph::vcount(r_igraph)
  r_igraph_nodes$igraph_name <- r_igraph_nodes$name


  pandas_igraph_nodes <- reticulate::r_to_py(r_igraph_nodes)

  netx_node_dict <- pandas_igraph_nodes$set_index("name")$to_dict("index")

  r_igraph_edges <- igraph::as_data_frame(r_igraph, "edges")

  netx_graph <- networkx$from_pandas_edgelist(
    r_igraph_edges,
    source = "from",
    target = "to"
  )
  networkx$set_node_attributes(netx_graph, netx_node_dict)
  netxio$write_json_graph(netx_graph, path)
}
