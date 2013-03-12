classdef Edge < handle
    % The class of an edge of a graph
    
    % An edge is assumed to be directed by default
    properties
        source % handle of a node
        sink % handle of a node
    end
    
    %methods (Abstract)
        %% Abstract methods
        % A subclass must implement a method to determine if two given
        % objects are equal
        %isequal(obj1, obj2); 
    %end
    
    methods (Access = public)
        % EQUALS determine if two edge objects are the same
        function yesno = equals(obj1, obj2)
            yesno = (obj1.source == obj2.source) && ...
            (obj1.sink == obj2.sink);
        end
        
        function obj = Edge(src, sink)
            obj.source = src;
            obj.sink = sink;
        end
    end
end