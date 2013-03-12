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
        newStates = {};
        e = initialNode.data;
        
        % Simulate signal generator
        [UT, dests, sigGenXF] = runSigGen(sig_gen_mdl,e.xSigGen,...
            e.location, e.t);
        tFinal = UT(end,1);
        [mdlXF, xlog] = runUntilTime(test_mdl, e.xTest, UT, tFinal);
        node = SysSim.StateNode(struct('xTest', mdlXF, ...
            'xSigGen', sigGenXF, 't', tFinal));
        
        graph.add_edge(SysSim.StateTrans(initialNode, node, xlog));
        
        if tFinal < tfinal
            % Two different constant maneuvers:
            %  either 20% throttle or 80% throttle
            for cmd = 1:dests
                e = SysSim.StateNode(struct('xTest', mdlXF, ...
                    'xSigGen', sigGenXF, 'location', cmd, 't', tFinal));
                graph.add_edge(SysSim.StateTrans(node, e, []));
                newStates{end+1} =  e;
            end
        end
    end

set_param(test_mdl, 'LoadInitialState', 'off');
set_param(sig_gen_mdl, 'LoadInitialState', 'off');
%%

end

