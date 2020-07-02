#!/usr/bin/env python

from networkx import Graph, is_directed, node_link_graph
from networkx.algorithms.bipartite import is_bipartite
from pandas import DataFrame

from json import dump
from pathlib import Path
from os import PathLike


def read_json_graph(path: PathLike) -> Graph:
    """Read a json link_data_format file with nodes, edges and attributes."""
    path: PathLike = Path(path)
    with open(path) as graph_file:
        return node_link_graph(load(graph_file))
        
        
def write_json_graph(graph: Graph, path: PathLike) -> None:
    """Write a json file including nodes, edges and attributes."""
    path: PathLike = Path(path)
    path.parent.mkdir(exist_ok=True, parents=True)
    with open(path, "w") as graph_file:
        dump(node_link_data(graph), graph_file)
        
        
def networkx2nodeattr(graph: Graph) -> DataFrame:
    """Return a DataFrame of nodes with attributes."""
    return DataFrame({'name': data[0], **data[1]}
                     for data in graph.nodes(data=True))
    
    
def networkx2edgeattr(graph: Graph) -> DataFrame:
    """Return DataFrames of edges with attributes.
    
    Note:
       `from` and `to` are adhering to default iGraph column names 
    """
    return networkx.to_pandas_edgelist(graph, source="from", target="to")
