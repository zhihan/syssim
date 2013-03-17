function graph = sys_sim(test_mdl, sig_gen_mdl, tfinal)
% SYS_SIM
    
load_system(test_mdl);
load_system(sig_gen_mdl);

set_param(test_mdl, 'LoadInitialState', 'off');
x0 = Simulink.BlockDiagram.getInitialState(test_mdl);

xI = struct('xTest', x0, 'xSigGen', [], 'location', 1, 't', 0.0);
%% initialize nodes and graph
graph = Graph.DG;
graph.nodes = SysSim.StateNode(xI);

bfs = Algo.BFS(@localExplore);
bfs.initialize(graph.nodes(1));
bfs.run();


    function newStates = localExplore(initialNode)
        %Local function used in BFS algorithm
        newStates = {};
        e = initialNode.data;
        
        % Simulate signal generator
        [UT, dests, sigGenXF] = runSigGen(sig_gen_mdl,e.xSigGen,...
            e.location, e.t);
        tFinal = UT(end,1);

        % Simulate the model until the final time of the segment
        [mdlXF, xlog] = runUntilTime(test_mdl, e.xTest, UT, tFinal);
        node = SysSim.StateNode(struct('xTest', mdlXF, ...
            'xSigGen', sigGenXF, 't', tFinal));
        
        graph.add_edge(SysSim.StateTrans(initialNode, node, xlog, UT));
        
        if tFinal < tfinal
            % For each branch, create a transition that takes the input
            % from one final state to multiple initial states.
            if dests > 0
                newStates = cell(1, dests);
                for cmd = 1:dests
                    % The new states has the same SimState values as the final
                    % states, except that they are on different branches. In
                    % the next step, the branch number is used in the signal
                    % generator to to generate different signals.
                    e = SysSim.StateNode(struct('xTest', mdlXF, ...
                        'xSigGen', sigGenXF, 'location', cmd, 't', tFinal));
                    graph.add_edge(SysSim.StateTrans(node, e, [], []));
                    newStates{cmd} =  e;
                end
            end
        end
    end

set_param(test_mdl, 'LoadInitialState', 'off');
set_param(sig_gen_mdl, 'LoadInitialState', 'off');
%%

end

