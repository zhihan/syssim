classdef StateTrans < Graph.Edge
    properties
        % The data of state transition is normally the simulation log 
        % of the state transition.
        data
    end
    methods
        function obj = StateTrans(src, sink, data)
            obj = obj@Graph.Edge(src, sink);
            obj.data = data;
        end
    end
        
end