function [paths, edges] = unwind(graph, root, level)
% UNWIND unwind the graph to a certain levels and return all the paths

if ~isa(graph, 'Graph.DG')
    error('Graph:Unwind:WrongGraph', 'Can only unwind directed graph');
end

paths = {root};
edges = {[]};
p = struct('nodeIdx', root, 'level', 1, 'row', 1);

queue = {p};

while ~emptyqueue()
    e = dequeue();
    % callback function for BFS
    if currentNode.level > level || ...
            isempty(currentNode.out)
        newNodes=  {};
        return;
    end
    out = currentNode.out;
    
    newNodes{1} = struct('nodeIdx', ...
        graph.edges(out(1)).sink, ...
        'level', currentNode.level +1, ...
        'row', currentNode.row);
    
    for i=2:length(out)
        paths{end+1} = paths{currentNode.row};
        edges{end+1} = edges{currentNode.row};
        rowIdx = length(paths);
        dst = graph.edges(out(i)).sink;
        addNodeToRow(rowIdx, dst, out(i));
        newNodes{end+1} = struct('nodeIdx', dst, ...
            'level', currentNode.level +1, ...
            'row', rowIdx);
    end
    % Add the element for the existing row
    addNodeToRow(currentNode.row, graph.edges(out(1)).sink, out(1));
    enqueue(newNodes);
end

    function addNodeToRow(rowIdx, node, edge)
        paths{rowIdx}(end+1) = node;
        edges{rowIdx}(end+1) = edge;
    end
    function enqueue( e)
        obj.queue = [queue e];
    end
    function yesno = emptyqueue()
        yesno = isempty(queue);
    end
    function e = dequeue()
        e = queue{1};
        queue = obj.queue(2:end);
    end
    
end