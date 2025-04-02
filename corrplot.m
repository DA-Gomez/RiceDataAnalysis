function out = corrplot()
%plots the correlation between two columns of a corr dataset specified by col1
%and col2
%i is to get the position of the title
% this is much like the one used in main, I just want it in a different
% meshgrid

global cammeoData
global osmancikData
global correlations
global data

plt = @(col1, col2, style) plot(col1, col2,style,col1, ...
    polyval(polyfit(col1, col2, 1),col1),'-');
%follows this:
    % p = polyfit(col1, col2,1);
    % f = polyval(p,col1); 
    % h = plot(col1, col2,'black.',col1,f,'-');


% i have decided to have the label in only one chart since all have the
% same colors
for i = 1:5
    %we want to make it so the second iteration we capture Major_Axis_Length/Minor_Axis_Length
    x = i * 2 - 1; %this will only serve us by being 1 and then 3 (other values after dont matter)
    y = x + 1; 

    subplot(1, 5, i);
    switch i % we do case switch because not all values are together
        case 3 %Area/Convex_Area
            h = plt([cammeoData{:, 1}], [cammeoData{:, 6}], 'c*');
            set(h(2), 'linewidth', 3)
            hold on
            h = plt([osmancikData{:, 1}], [osmancikData{:, 6}], 'black.');
            set(h(2), 'linewidth', 3)
            hold off
            legend('Cammeo', 'Cammeo Linear Regression', 'Osmancik', 'Osmancik Linear Regression')
            title(correlations.Properties.VariableNames{i});
            xlabel(data.Properties.VariableNames{1});
            ylabel(data.Properties.VariableNames{6});

        case 4 %Eccentricity/Major_Axis_Length
            h = plt([cammeoData{:, 5}], [cammeoData{:, 3}], 'c*');
            set(h(2), 'linewidth', 3)
            hold on
            h = plt([osmancikData{:, 5}], [osmancikData{:, 3}], 'black.');
            set(h(2), 'linewidth', 3)
            hold off

            title(correlations.Properties.VariableNames{i});
            xlabel(data.Properties.VariableNames{5});
            ylabel(data.Properties.VariableNames{3});

        case 5 %Eccentricity/Minor_Axis_Length
            h = plt([cammeoData{:, 5}], [cammeoData{:, 4}], 'c*');
            set(h(2), 'linewidth', 3)
            hold on
            h = plt([osmancikData{:, 5}], [osmancikData{:, 4}], 'black.');
            set(h(2), 'linewidth', 3)
            hold off

            title(correlations.Properties.VariableNames{i});
            xlabel(data.Properties.VariableNames{5});
            ylabel(data.Properties.VariableNames{4});


        otherwise
            h = plt([cammeoData{:, x}], [cammeoData{:, y}], 'c*');
            set(h(2), 'linewidth', 3)
            hold on
            h = plt([osmancikData{:, x}], [osmancikData{:, y}], 'black.');
            set(h(2), 'linewidth', 3)
            hold off

            title(correlations.Properties.VariableNames{i});
            xlabel(data.Properties.VariableNames{x});
            ylabel(data.Properties.VariableNames{y});
    end
    %assignations must be cells or table, you cant do outVal{1, 2}
    hold on
end

hold off
