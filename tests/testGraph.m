function testGraph()
initTestSuite;
end

function testCreate()
% Test graph creation
g = Graph.DG;
v = TestNode(1);
[idx, isnew] = g.add_node(v);
assertEqual(idx, 1);
assertTrue(isnew);

[idx, isnew] = g.add_node(v);
assertEqual(idx, 1);
assertFalse(isnew);

v2 = TestNode(2);
[idx, isnew] = g.add_node(v2);
assertEqual(idx, 2);
assertTrue(isnew);

[idx, isnew] = g.add_edge(Graph.Edge(v,v2));
assertEqual(idx,1);
assertTrue(isnew);
[idx, isnew] = g.add_edge(Graph.Edge(v,v2));
assertEqual(idx,1);
assertFalse(isnew);

end
