%% Testing Auto-Transmission System
% This demo uses a simple Stateflow chart to generate the test input
% (throttlecommand) to the auto transmission system. The test is either
% step up or step down at given time intervals.

%%
% The system under test is adapted from a Simulink example model.
mdl = 'mytrans_test';
open_system(mdl);

%%
% The test case generator is modeled in Stateflow.
sig_gen_mdl = 'sf_gen';
open_system(sig_gen_mdl);

%% Branch-time simulation
% Simulate the test cases using branch-time simulation.
graph = sys_sim(mdl, sig_gen_mdl, 20); 

%%
% Plot the transition system in the phase phase of the system.
figure;
plottran(graph);

%%
% Extract all simulation runs and plot the simulation results in one
% figure.
figure;
[paths, edges] = Graph.unwind(graph, graph.nodes(1), 10);
plotpath(edges);

%%
% 
close all;
bdclose(mdl);
bdclose(sig_gen_mdl);
