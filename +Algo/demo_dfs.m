function demo_dfs()
a = Algo.NamedNode();
a.name = 'a';

b = Algo.NamedNode();
b.name = 'b';

c = Algo.NamedNode();
c.name = 'c';

d = Algo.NamedNode();
d.name = 'd';

g = Graph.DG();
g.add_node(a); 
g.add_node(b);
g.add_node(c);
g.add_node(d);

g.add_edge(Graph.Edge(a,b));
g.add_edge(Graph.Edge(a,c));
g.add_edge(Graph.Edge(c,b));
g.add_edge(Graph.Edge(b,d));
g.add_edge(Graph.Edge(d,b));

dfs = Algo.DFS(@(node) local_discover(g,node) , @local_finish);
dfs.initialize(a);
dfs.run;
fprintf('\n==============Run again=============\n');
dfs.initialize(a);
dfs.run;

end


function newnodes = local_discover(g, node)
outEdges = node.out;
newnodes = {};
for i=1:length(outEdges)
    newnodes{end+1} = outEdges(i).sink;
end
fprintf('\n Discovering from %s\n' ,node.name);
end

function local_finish(node)
fprintf('\n Finishing %s\n', node.name);
end