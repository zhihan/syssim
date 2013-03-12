mdl = 'galton_mdl';
sig_gen_mdl = 'galton_gen_sf';

graph = sys_sim(mdl, sig_gen_mdl, 4); 
% simulate until 10, making changes at interval of 1.

%%
% plot phase plane graph
figure;
plottran(graph);

%%
% Extract all simulation runs and plot them
figure;
[paths, edges] = Graph.unwind(graph, graph.nodes(1), 8);
plotpath(graph, edges);
