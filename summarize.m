function out = summarize(dataSet)
%returns table with, min, Q1, median, Q3, mean, variance, std, iqr
% of each corresponding attribute
data = table2array(dataSet(:, 1:7));

column_min = min(data);
column_median = median(data);
column_mean= mean(data);
column_max = max(data);
column_var = var(data);
column_std = std(data);
q1 = quantile(data, 0.25);
q3 = quantile(data, 0.75);
column_iqr = iqr(data); 

data = [column_min; column_median; column_max; column_mean; 
    column_var; column_std; q1; q3; column_iqr];

data = array2table(data, "VariableNames", ...
        [ 
            "Area", "Perimeter", "Major Axis Length", "Minor Axis Length", ...
            "Eccentricity", "Convex Area", "Extent", 
        ], ...
        "RowNames", ...
        [
            "Min", "Median", "Max", "Mean", "Variance", ...
            "Standard Deviation", "Q1", "Q3", "IQR"
        ] ...
    );
out = data;
end