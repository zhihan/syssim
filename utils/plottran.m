function plottran(graph)
hold on;
nodes = graph.nodes;
edges= graph.edges;
for i=1:length(edges)
    src = edges(i).source;
    sink = edges(i).sink;
    x1 = src.getValues();
    x2 = sink.getValues();
    
    plot([x1(1) x2(1)], [x1(2), x2(2)], 'o');
    %arrowsize = norm(x2 - x1) * 0.1;
    %plotarrow([x1(1) x2(1)], [x1(2), x2(2)], 'b', arrowsize);
    traj = edges(i).data;
    if ~isempty(traj)
        plot(traj.signals(1).values, traj.signals(2).values, 'k-');
    end
end
end

