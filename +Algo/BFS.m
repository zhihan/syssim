classdef BFS < handle
    % Breadth-first search algorithm
    properties
        queue
        
        % To use a BFS algorithm the caller need to implement a 
        % visit callback function that for given a node, it visits the node
        % and return a cell array of newly discovered nodes.
        visitCallback % the callback function when first visit a node
        
        mark1 % Used to prevent multiple visit
    end
    
    methods (Access = public)
        % main function 
        function run(obj)
            obj.mark1 = ~obj.mark1;
            while ~obj.emptyqueue()
                 e = obj.dequeue();
                 % call the callback visit function 
                 if e.mark1 ~= obj.mark1
                     % Not explored yet
                     newE = obj.visitCallback(e);
                     e.mark1 = obj.mark1;
                     if iscell(newE)
                         for i=1:length(newE)
                             if newE{i}.mark1~=obj.mark1
                                 % Not visited, enqueue it
                                 obj.enqueue(newE);
                             end
                         end
                     else
                         if newE.mark1 ~= obj.mark1
                             obj.enqueue(newE);
                         end
                     end
                     obj.enqueue(newE);
                 end
            end
        end
        
        % constructor
        function obj = BFS(callback)
            obj.visitCallback = callback;
        end
        function initialize(obj, e)
            obj.queue = {e};
            obj.mark1 = e.mark1;
        end
    end
    
    methods (Access = private)
        % Queue management
        function enqueue(obj, e)
            obj.queue = [obj.queue e];
        end
        function yesno = emptyqueue(obj)
            yesno = isempty(obj.queue);
        end
        function e = dequeue(obj)
            e = obj.queue{1};
            obj.queue = obj.queue(2:end);
        end
    end
end