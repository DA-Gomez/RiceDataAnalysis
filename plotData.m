function out = plotData(dataset, name)
%Takes a dataset and plots it according to the first 7 attributes. 
% (last attribute is a categorical value)

% plots: histogram, boxplot

value = 0; %keeps track of meshgrid position
figure('Name', name)
hold on
for i = 1:(width(dataset)-1)
    subplot(2, 7, i);
    histogram([dataset{:, i}])
    title(dataset.Properties.VariableNames{i});
    xlabel(dataset.Properties.VariableNames{i});
    ylabel("Frequency");    
end
value = i;

%another for loop to keep window structure
for i = 1:(width(dataset)-1)
    j = value + i;
    subplot(2, 7, j);
    boxplot([dataset{:, i}])
    title(dataset.Properties.VariableNames{i});
    ylabel(dataset.Properties.VariableNames{i});
end

hold off
end