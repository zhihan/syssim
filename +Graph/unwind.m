function [paths, edges] = unwind(graph, root, level)
% UNWIND unwind the graph to a certain levels and return all the paths

if ~isa(graph, 'Graph.DG')
    error('Graph:Unwind:WrongGraph', 'Can only unwind directed graph');
end

paths = {root};
edges = {[]};
p = struct('node', root, 'level', 1, 'row', 1);

queue = {p};

while ~emptyqueue()
    e = dequeue();
    % callback function for BFS
    currentNode = e.node;
    if e.level > level || isempty(currentNode.out)
        newNodes=  {};
        return;
    end
    out = currentNode.out;
    newNodes = {};
    newNodes{1} = struct('node', ...
        out(1).sink, ...
        'level', e.level +1, ...
        'row', e.row);
    
    for i=2:length(out)
        paths{end+1} = paths{e.row};
        edges{end+1} = edges{e.row};
        rowIdx = length(paths);
        dst = out(i).sink;
        addNodeToRow(rowIdx, dst, out(i));
        newNodes{end+1} = struct('node', dst, ...
            'level', e.level +1, ...
            'row', rowIdx);
    end
    % Add the element for the existing row
    addNodeToRow(e.row, out(1).sink, out(1));
    enqueue(newNodes);
end

    function addNodeToRow(rowIdx, node, edge)
        if isempty(paths{rowIdx})
            paths{rowIdx} = node;
        else
            paths{rowIdx}(end+1) = node;
        end
        if isempty(edges{rowIdx}) 
            edges{rowIdx} = edge;
        else
            edges{rowIdx}(end+1) = edge;
        end
    end
    function enqueue(e)
        queue = [queue e];
    end
    function yesno = emptyqueue()
        yesno = isempty(queue);
    end
    function e = dequeue()
        e = queue{1};
        queue = queue(2:end);
    end
    
end