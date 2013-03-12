classdef Node < handle
    % The class of a node
    
    properties
        in  % array of handles
        out % array of handles
        mark1 = false
        mark2 = false
    end
    
    methods
        function addOutEdge(obj, edgeIdx)
            obj.out = [obj.out; edgeIdx];
        end
        function addInEdge(obj, edgeIdx)
            obj.in = [obj.in; edgeIdx];
        end
        function yesno = equals(obj1, obj2)
            yesno = isequal(obj1, obj2);
        end
    end
end