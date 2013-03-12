function [UT, dests, XF] = runSigGen(mdl, xI, command, tnow)
% runSigGen Run the signal generator start from the given time and initial

set_param(mdl, 'LoadInitialState', 'on', 'InitialState', 'xInitial');
xInitial = xI;
opt = simset('SrcWorkspace', 'current', 'DstWorkspace', 'current', ...
    'SaveFormat','StructureWithTime');

st = 0.1;
T = (tnow:st:tnow+st)';
UT = [T, command*ones(size(T))];
[t,x,y] =  sim(mdl, T, opt, UT); 
% Simulate for one step and get dests 
duration = y.signals(3).values(end);
dests = y.signals(2).values(end);

set_param(mdl, 'SaveFinalState','on', 'FinalStateName','XF',...
    'SaveCompleteFinalSimState','on');

T = (tnow:st:tnow+duration)';
UT = [T, command*ones(size(T))];
[t,x,y] = sim(mdl, tnow+duration, opt, UT);

% Get the next duration
UT = [t, y.signals(1).values];

end