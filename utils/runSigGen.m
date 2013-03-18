function [UT, dests, XF] = runSigGen(mdl, xI, branch, tnow) %#ok<STOUT>
% runSigGen Run the signal generator start from the given time and initial
% state
%
% [UT, dests, XF] = runSigGen(mdl, xI, branch, tnow)
%
% Simulates the signal generator and produces the test signal. 
%
% Inputs
%   mdl - Model of the signal generator
%   xI - initial state of the test generator
%   branch - An integer indicating which branch is the current simulation
%   tnow - The start of the simulation time
%
% Outputs
%   UT - [time, u] array for the test signal to use for SUT
%   dests - total number of branches to take in the next step, each branch
%           is indicated by a positive number [1...dests]. 
%   XF - Final state of the signal generator at the end of this step
%


%% Implementation details
%
% The simulating of the test generator is a little involved. Simulink
% usually require a predefined stop time for simulation, however in this
% mode we do not assume such knowledge. The duration of the simulation is
% provided in the third output of the model. To simulate the signal
% generator, first simulates the model for one single step, the model
% simulates and generate the duration of the simulation. Then we restore
% the initial state and simulates the model again for the duration given.

%% 
% 
set_param(mdl, 'LoadInitialState', 'on', 'InitialState', 'xInitial');

xInitial = xI; %#ok<NASGU>
opt = simset('SrcWorkspace', 'current', 'DstWorkspace', 'current', ...
    'SaveFormat','StructureWithTime');
%%
% Run single-step simulation to get the constants
st = 0.1;

% The initial time is set to zero to avoid warning from SimState. The
% actual time will be overrriden by the t from SimState.
% The last time is provided so that it only runs one step.
T = [0, tnow+st]';

UT = [T, branch*ones(size(T))];
[~,~,y] =  sim(mdl, T, opt, UT); 


% Simulate for one step and get dests 
duration = y.signals(3).values(end,:);

if length(duration) > 1 
    error('RunSigGen:VectorDuration', ...
        'A vector of simulation duration is generated');
elseif  duration <0
    error('RunSigGen:NegativeDuration', ...
        'A negative duration value is found');
end
    
% Get the number of branches for the next step
dests = y.signals(2).values(end,:);

%%
% Rerun full simulation to get the test signal
set_param(mdl, 'SaveFinalState','on', 'FinalStateName','XF',...
    'SaveCompleteFinalSimState','on');

T = (tnow:st:tnow+duration)';
UT = [T, branch*ones(size(T))];
[t,~,y] = sim(mdl, tnow+duration, opt, UT);

% Get the next duration
UT = [t, y.signals(1).values];

end