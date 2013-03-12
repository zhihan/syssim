classdef StateNode < Graph.Node
    % A state node is a graphical node containing state data
    properties
       data  % A place holder for user data
    end
    methods
        function yesno = equals(obj1, obj2)
            % Equality relationship is defined by closeness
            if obj1 == obj2
                % If the objects are identical
                yesno = true;
            else
                yesno = isclose(obj1.data, obj2.data);
            end
        end
        
    end
    %%
    % Methods distinct for state nodes
    methods
        function obj = StateNode(data)
            obj.data = data;
        end
        
        function val = getValues(obj)
            logged = getLoggedState(obj.data);
            val = [logged.values];
        end
    end
    
end

function xstruct = getLoggedState(data_)
% Local function to get all of the logged states of the data
data = data_.xTest; %
if isa(data, 'struct') && isfield(data, 'signals')
    xstruct = data.signals;
elseif isa(data, 'Simulink.SimState.ModelSimState')
    xstruct = data.loggedStates;
end
end

function yesno = isclose(data1, data2)
% Determine if two states are close or not
if isfield(data1, 'location') 
    if isfield(data2, 'location')
        if data1.dest~=data2.dest
            yesno = false;
            return;
        end
    else
        yesno = false;
        return;
    end
elseif isfield(data2, 'location')
    yesno = false;
    return;
end
% Otherwise check the continuous states
logged1 = getLoggedState(data1);
logged2 = getLoggedState(data2);
x1 = [logged1.values];
x2 = [logged2.values];
yesno = (norm(x1 -x2) <= 1e-3);
end

