function plotpath(paths)
% PLOTPATH Plot all the paths of the transition system


for i=1:length(paths)
    path = paths{i};
    
    for j=1:length(path)
        log = path(j).data;
        if ~isempty(log)
            n = length(log.signals);
            for k=1:n
                subplot(n, 1, k);
                hold on;
                plot(log.time, log.signals(k).values);
                plot(log.time(1), log.signals(k).values(1), 'ro');
            end
        end
    end
end

% Format the graph
for k=1:n
    subplot(n,1,k);
    box on;
    grid on;
end

subplot(n,1,n);
xlabel('t');
end