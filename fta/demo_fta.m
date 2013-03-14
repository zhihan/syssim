%% Fault-Tree Analysis Demo 
% Demonstrating FTA with systematic simulation
%

mdl = 'mysys';
sig_gen_mdl = 'fta_gen_sl';

graph = sys_sim(mdl, sig_gen_mdl, 120); 
% simulate until 10, making changes at interval of 1.


%%
% Extract all simulation runs and plot them
figure;
[paths, edges] = Graph.unwind(graph, graph.nodes(1), 8);
plotpath(graph, edges);
