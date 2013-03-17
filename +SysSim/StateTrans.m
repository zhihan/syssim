classdef StateTrans < Graph.Edge
    properties
        % The data of state transition is normally the simulation log 
        % of the state transition.
        data
        % The input signal that drives the simulation.
        input
    end
    methods
        function obj = StateTrans(src, sink, data, input)
            obj = obj@Graph.Edge(src, sink);
            obj.data = data;
            obj.input = input;
        end
    end
        
end