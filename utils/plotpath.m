function plotpath(graph, paths)
for i=1:length(paths)
    path = paths{i};
    
    for j=1:length(path)
        log = path(j).data;
        if ~isempty(log)
            n = length(log.signals);
            for k=1:length(log.signals)
                subplot(n, 1, k);
                hold on;
                plot(log.time, log.signals(k).values);
                plot(log.time(1), log.signals(k).values(1), 'ro');
            end
        end
    end
end
end