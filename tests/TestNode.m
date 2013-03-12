classdef TestNode < Graph.Node
    properties
        id
    end
    
    methods
        function obj = TestNode(i)
            obj.id = i;
        end
        
        function yesno = equals(this, other)
            if this == other
                yesno = true;
            else
                yesno = (this.id == other.id);
            end
        end
    end
end