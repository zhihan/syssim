function plotinput(edges)
% PLOTINPUT Plot all the edges of the transition system

n= length(edges);
for i=1:length(edges)
    path = edges{i};
    subplot(n,1,i);
    for j=1:length(path)
        log = path(j);
        hold on;
        if ~isempty(log.input)
            plot(log.input(:,1), log.input(:,2));
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