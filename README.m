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
%  (c)---->| generator |==>[Manager]--->|  under   |
%          +-----------+                |  test    |
%                                       +----------+

% The test generator models a branch-time system where the uncertainty
% of the system is parameterized by the input c. The input c to the
% signal generator is an integer ranged from 1 to the number of
% branches, indicating which branch is currently taking.

% Currently the test generator generates piecewise constant signals.
% The test generator must have three outputs: u, num_branches, and
% duration, where u is the value of signal to the System Under Test
% (SUT). num_branches indicates how many branch is there after this
% step, and duration is the simulation duration of this mode.
%

% The engine keeps track of the SimState of the test generator as well
% as the SimState of the SUT for different purposes. The test
% generator does not interact with SUT. The interaction between the
% test generator and SUT is managed by the manager through the
% root-level input/output ports.
