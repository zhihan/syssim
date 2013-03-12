function [xfinal, x] = runUntilTime(mdl, xI, UT, tFinal)
% RUNUNTILTIME Run the model until the final time
set_param(mdl, 'LoadInitialState', 'on', 'InitialState', 'xInitial');

if ~isstruct(xI)
    xI.loggedStates = xI.loggedStates; % force reset
end

xInitial = xI; %#Ok<NASGU>

set_param(mdl, 'SaveFinalState', 'on', 'FinalStateName', 'xF', ...
    'SaveCompleteFinalSimState', 'on');
opt = simset('SrcWorkspace', 'current', 'DstWorkspace', 'current', ...
    'SaveFormat','StructureWithTime');
[t,x] = sim(mdl, tFinal, opt, UT);

xfinal = xF;
end