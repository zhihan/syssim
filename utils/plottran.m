function plottran(graph, varargin)
% PLOTTRAN Plot the transition system on phase plane.

if nargin > 1
    showarrow = varargin{1};
else
    showarrow = false;
end

hold on;
nodes = graph.nodes;
edges= graph.edges;
for i=1:length(edges)
    src = edges(i).source;
    sink = edges(i).sink;
    x1 = src.getValues();
    x2 = sink.getValues();
    
    plot([x1(1) x2(1)], [x1(2), x2(2)], 'o');
    if showarrow
        arrowsize = norm(x2 - x1) * 0.1;
        plotarrow([x1(1) x2(1)], [x1(2), x2(2)], 'b', arrowsize);
    end
    traj = edges(i).data;
    if ~isempty(traj)
        plot(traj.signals(1).values, traj.signals(2).values, 'k-');
    end
end

box on;
end

