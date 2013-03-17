%% Event-Tree Analysis Demo 
% This script demonstrates the application of branch-time simulation for
% Event-Tree Analsis (ETA). The system under test is a simple stabilizing
% system. The discrete event are abrupt changes in the input signal to the
% system.
%

mdl = 'mysys';
open_system(mdl);

sig_gen_mdl = 'fta_gen_sl';
open_system(sig_gen_mdl);

% simulate until 120, which exceeds all the test cases
graph = sys_sim(mdl, sig_gen_mdl, 120); 


%% Plot test cases
% Plot all the test cases
[paths, edges] = Graph.unwind(graph, graph.nodes(1), 8);
plotinput(edges);


%%
% Extract all simulation runs and plot them
figure;
plotpath(edges);
