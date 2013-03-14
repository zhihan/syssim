% Systematic simulation of Simulink models
%
% This is a prototype implementation that serves as proof-of-concept.
%
% To use the code, the Simulink model needs to be configured in a special
% format.
% 
% A typical setup of the system configuration is like the following
%
%          +-----------+                +----------+
%          | Test      |                | System   |
%  (c)---->| generator |==>[SysSim]---->|  under   |
%          +-----------+                |  test    |
%                                       +----------+

% Introduction
%

% The test generator models a branch-time system where the uncertainty of
% the system is parameterized by the branch number c. The input c to the
% signal generator is an integer ranged from 1 to the number of branches,
% indicating which branch is currently taking.

% The test generator must have three outputs: u, num_branches, and duration
% of this simulation, where u is the test signal to the System Under Test
% (SUT). num_branches indicates how many branches should there be after
% simulating this step, and duration is the simulation duration of this
% mode.
%

% The engine keeps track of the SimState of the test generator as well
% as the SimState of the SUT for different purposes. The test
% generator does not interact with SUT. The interaction between the
% test generator and SUT is managed by the manager through the
% root-level input/output ports.

% Limitations
%

% - Due to the lack of support in external Simulink API for event
% detection, this implementation require that the test generator computes
% the duratio of each test signal. Thus one cannot have test cases that
% stops based on state events.
%