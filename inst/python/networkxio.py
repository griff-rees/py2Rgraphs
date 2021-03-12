#!/usr/bin/env python

from json import dump, load
from os import PathLike
from pathlib import Path

from networkx import Graph, node_link_graph, to_pandas_edgelist
from pandas import DataFrame


def read_json_graph(path: PathLike) -> Graph:
    """Read a json link_data_format file with nodes, edges and attributes."""
    path = Path(path)
    with open(path) as graph_file:
        return node_link_graph(load(graph_file))
        
        
def write_json_graph(graph: Graph, path: PathLike) -> None:
    """Write a json file including nodes, edges and attributes."""
    path = Path(path)
    path.parent.mkdir(exist_ok=True, parents=True)
    with open(path, "w") as graph_file:
        dump(node_link_data(graph), graph_file)
        
        
def networkx2nodeattr(graph: Graph) -> DataFrame:
    """Return a DataFrame of nodes with attributes."""
    return DataFrame(
        {'id': data[0], **data[1]} for data in graph.nodes(data=True)
    )
    
    
def networkx2edgeattr(
    graph: Graph,
    from_col_name: str = "from",
    to_col_name: str = "to"
) -> DataFrame:
    """Return DataFrames of edges with attributes.
    
    Note:
       `from` and `to` are adhering to default iGraph column names 
    """
    return to_pandas_edgelist(graph, source=from_col_name, target=to_col_name)
