%% Event-Tree Analysis Demo 
% This script demonstrates the application of branch-time simulation for
% Event-Tree Analsis (ETA). The system under test is a simple stabilizing
% system. The discrete event are abrupt changes in the input signal to the
% system.
%

%% Introduction
% The system under test is a simple second order system plant driven by a
% discrete-time controller that tracks the input signal.
mdl = 'mysys';
open_system(mdl);

%%
% The system input consists of a set of faulty event, the events are
% specified by a set of Signal builder block which in turns is selected by
% a selector block driven by Stateflow chart.
sig_gen_mdl = 'fta_gen_sl';
open_system(sig_gen_mdl);

%%
% simulate until 120, which exceeds all the test cases
graph = sys_sim(mdl, sig_gen_mdl, 120); 


%% Plot test cases
% Plot all the test cases
[paths, edges] = Graph.unwind(graph, graph.nodes(1), 8);
plotinput(edges);


%% Examine results
% Extract all simulation runs of all the test cases and plot the results
% in the same plot.
figure;
plotpath(edges);

%%
%
close all
bdclose(sig_gen_mdl);
bdclose(mdl);