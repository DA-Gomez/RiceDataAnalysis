
data = importdata('Rice_Cammeo_Osmancik.arff'); % returns a column vector

%Turn the unstructured data into sctructured data
data = handleData(data);
cammeoData= data(data.Class == "Cammeo", :);
osmancikData= data(data.Class == "Osmancik", :);

% do a statistical summary on the data fed
summary = summarize(data);
cammeoSummary = summarize(cammeoData);
osmancikSummary = summarize(osmancikData);

%by this point we can filter out the outliers by using iqr
%Statistics say we can afford to remove data due to the amount of it
outliers = @(dataset, summ) all(table2array( ...
            dataset(:, 1:7) <= (summ{"Q3", :} + 1.5*summ{"IQR", :}) & ...
            dataset(:, 1:7) >= (summ{"Q1", :} - 1.5*summ{"IQR", :})), 2);

data = data(outliers(data, summary), :);
cammeoData = data(outliers(cammeoData, cammeoSummary), :);
osmancikData = data(outliers(osmancikData, osmancikSummary), :);

%we plot the clean and ready data
plotData(data, 'All data')
plotData(cammeoData, 'Cammeo data')
plotData(osmancikData, 'Osmancik data')

%correlation data analysis
correlations = array2table(zeros(2, 5), "VariableNames", ...
        [ 
            "Perimeter/Area", "Major Axis Length/Minor Axis Length", "Area/Convex Area", ...
            "Eccentricity/Major Axis Length", "Eccentricity/Minor Axis Length"
        ], ...
        "RowNames",["Covariance", "Correlation Coefficient"]);

figure('Name', "Correlation Measures")
for i = 1:5
    %we want to make it so the second iteration we capture Major_Axis_Length/Minor_Axis_Length
    x = i * 2 - 1; %this will only serve us by being 1 and then 3 (other values after dont matter)
    y = x + 1; 

    subplot(1, 5, i);
    switch i % we do case switch because not all values are together
        case 3 %Area/Convex_Area
            outVal = corrmeasures([data{:, 1}], [data{:, 6}]);
            scatter([data{:, 1}], [data{:, 6}], 1, 'filled',"black")
            title(correlations.Properties.VariableNames{i});
            xlabel(data.Properties.VariableNames{1});
            ylabel(data.Properties.VariableNames{6});

        case 4 %Eccentricity/Major_Axis_Length
            outVal = corrmeasures([data{:, 5}], [data{:, 3}]);
            scatter([data{:, 5}], [data{:, 3}], 1, 'filled',"black")
            title(correlations.Properties.VariableNames{i});
            xlabel(data.Properties.VariableNames{5});
            ylabel(data.Properties.VariableNames{3});

        case 5 %Eccentricity/Minor_Axis_Length
            outVal = corrmeasures([data{:, 5}], [data{:, 4}]);
            scatter([data{:, 5}], [data{:, 4}], 1, 'filled',"black")
            title(correlations.Properties.VariableNames{i});
            xlabel(data.Properties.VariableNames{5});
            ylabel(data.Properties.VariableNames{4});

        otherwise
            outVal = corrmeasures([data{:, x}], [data{:, y}]);
            scatter([data{:, x}], [data{:, y}], 1, 'filled',"black")
            title(correlations.Properties.VariableNames{i});
            xlabel(data.Properties.VariableNames{x});
            ylabel(data.Properties.VariableNames{y});
    end
    %assignations must be cells or table, you cant do outVal{1, 2}
    correlations(1, i) = outVal(1, 1); 
    correlations(2, i) = outVal(1, 2);
    hold on
end

hold off

%write table only allows for 1 table to be written
writetable(data, "./ResultingData/Rice_Data.xlsx")
writetable(summary, "./ResultingData/Rice_Data_Summary.xlsx")
writetable(cammeoData, "./ResultingData/Cammeo_Data.xlsx")
writetable(cammeoSummary, "./ResultingData/Cammeo_Data_Summary.xlsx")
writetable(osmancikData, "./ResultingData/Osmancik_Data.xlsx")
writetable(osmancikSummary, "./ResultingData/Osmancik_Data_Summary.xlsx")
writetable(correlations, "./ResultingData/Data_Correlation.xlsx")
