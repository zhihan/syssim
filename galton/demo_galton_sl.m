%% Galton Board with Simulink

%% Introduction
% This demo uses a very simple model for the Galton board. The switching
% logic at the pegs are modeled by non-deterministic transitions in the
% Stateflow diagram. The physical model of falling balls are modeled as
% simple integrators.
%
% This model uses a test generator that is pure Simulink model, i.e.,
% without Stateflow chart.

%%
% The system model is implemented using integrators.
mdl = 'galton_mdl';
open_system(mdl);

%%
% The non-deterministic transitions are modeled by a Simulink model.
sig_gen_mdl = 'galton_gen_sl';
open_system(sig_gen_mdl);

%% Branch-time simulation
% To fully simulate the system, we invoke the systematic simulation
% function to create a transition system while running the simulations.

% simulate until 10, making changes at interval of 1.
graph = sys_sim(mdl, sig_gen_mdl, 4); 

%% Examine the results
% Plot the transition system in the phase plane of the system.
f = figure;
plottran(graph, true);
a = get(f, 'CurrentAxes');
axis equal;
set(a, 'YDir', 'reverse');

%%
% Extract all simulation runs and plot them
figure;
[paths, edges] = Graph.unwind(graph, graph.nodes(1), 8);
plotpath(edges);

%%
%
close all
bdclose(mdl);
bdclose (sig_gen_mdl);