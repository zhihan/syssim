classdef DG < handle
    % Graph.DG - An abstract class for directed graph
    
    % Class for directed graph 
    
    properties 
        % Array of nodes and edges
        nodes  
        edges
    end
    
   %%
    methods (Access = public)
        %%
        function idx = find_node(obj, node)
            % Find the set of nodes that is equal to the given node
            idx = -1;
            for myIdx=1:length(obj.nodes)
                if equals(obj.nodes(myIdx), node)
                    idx= myIdx;
                    return
                end
            end
        end
        
        function idx = find_all_nodes(obj, fcn, varargin)
            % Find the set of nodes that satisfy certain conditions
            filt = false(1, length(obj.nodes));
            
            for myIdx=1:length(obj.nodes)
                filt(myIdx) = fcn(obj.nodes(myIdx), varargin{:});
            end
            idx = find(filt);
        end
        
        function idx = find_edge(obj, edge)
            % Find the set of edge that is equal to the given edge
            idx = -1;
            % xxx(enh) This algorithm is slow with MATLAB.
            for myIdx=1:length(obj.edges)
                if equals(obj.edges(myIdx), edge)
                    idx= myIdx;
                    return
                end
            end
        end
    end
    
    methods (Access = public)
        % Graph manipulation: add node, add edge, delete node
        function [idx, isnew] = add_node(obj, node)
            idx = obj.find_node(node);
            isnew = false;
            if idx==-1
                if isempty(obj.nodes)
                    obj.nodes = node;
                    idx = 1;
                    isnew = true;
                else
                    obj.nodes(end+1) = node;
                    idx = length(obj.nodes);
                    isnew = true;
                end
            end
        end
        
        % Add an edge to the graph
        function [idx, isnew] = add_edge(obj, edge)
            idx = obj.find_edge(edge);
            isnew = false;
            if idx==-1
                if isempty(obj.edges)
                    obj.edges = edge;
                else
                    obj.edges(end+1) = edge;
                end
                idx = length(obj.edges);
                edge.source.addOutEdge(edge);
                edge.sink.addInEdge(edge);
                isnew = true;
            end
        end
    end
end
