classdef DFS < handle
    % A class of Depth-First Search algorithm
    properties
        queue
        mark1
        mark2
        discoverCallback
        finishCallback
    end
    
    methods (Access = public)
        function run(obj)
            obj.mark1 = ~obj.mark1; % Flip the flags
            obj.mark2 = ~obj.mark2; 
            while ~obj.emptyqueue()
                 e = obj.queuetop();
                 if e.mark1 ~= obj.mark1
                     % Need to explore the node
                    newE = obj.discoverCallback(e);
                    e.mark1 = obj.mark1;
                    if ~isempty(newE)
                        if iscell(newE)
                            for i=1:length(newE)
                                if newE{i}.mark1~=obj.mark1
                                    obj.enqueue(newE);
                                end
                            end
                        else
                            if newE.mark1 ~= obj.mark1
                                obj.enqueue(newE);
                            end
                        end
                    else
                        % Reach a terminal node
                        e = obj.dequeue();
                        if e.mark2 ~= obj.mark2
                            obj.finishCallback(e);
                            e.mark2 = obj.mark2;
                        end
                    end
                 else
                     e = obj.dequeue();
                     if e.mark2 ~= obj.mark2
                        obj.finishCallback(e);
                        e.mark2 = obj.mark2;
                     end
                 end
            end
        end
        
        function obj = DFS(callback1, callback2)
            obj.discoverCallback = callback1;
            obj.finishCallback = callback2;
        end
        function initialize(obj, e)
            obj.queue= {e};
            obj.mark1 = e.mark1;
            obj.mark2 = e.mark2;
        end
    end
    methods (Access = private)
        function enqueue(obj, e)
            % push the elements to the back if it is
            % not in the queue yet
            if iscell(e)
                for i=1:numel(e)
                    obj.queue{end+1} = e{i};
                end
            else
                obj.queue{end+1} =  e;
            end
        end
        function yesno = emptyqueue(obj)
            yesno = isempty(obj.queue);
        end
        function e = dequeue(obj)
            % pop element from the back
            e = obj.queue{end};
            obj.queue = obj.queue(1:end-1);
        end
        function e = queuetop(obj)
            e = obj.queue{end};
        end
        
    end
end