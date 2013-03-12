mdl = 'mytrans_test';
sig_gen_mdl = 'sf_gen';

graph = sys_sim(mdl, sig_gen_mdl, 20); 
% simulate until 10, making changes at interval of 1.

%%
% plot phase plane graph
figure;
plottran(graph);

%%
% Extract all simulation runs and plot them
figure;
[paths, edges] = Graph.unwind(graph, graph.nodes(1), 10);
plotpath(graph, edges);
