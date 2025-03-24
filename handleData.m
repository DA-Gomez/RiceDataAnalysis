
function out = handleData(rawData)
% Rice_Cammeo_Osmancik.arff contains a total of 3810 points of data with 8
% attributes. 
% The 8 attributes of a single data point are found in one cell, in a string, separated by a coma
% It also contains extra text that begins with % and @ that needs to be removed

data = rawData;

%filters out the descriptors
data = data(~(startsWith(data, '@')) & ~(startsWith(data, '%'))); 

data = split(data, ',');
% this returns a filled out 3810x8 cell array, whith the data stored in a
% cell array

data = cell2table(data, "VariableNames", ["Area", "Perimeter", "MajorAxisLength", ...
    "MinorAxisLength", "Eccentricity", "ConvexArea", "Extent", "Class"]);

%because each attribute data is in a string inside cells, we need to handle the data
%into its correct format and datatype
data.Area = round(str2double(data.Area), 4);
data.Perimeter = round(str2double(data.Perimeter), 4);
data.MajorAxisLength = round(str2double(data.MajorAxisLength), 4);
data.MinorAxisLength = round(str2double(data.MinorAxisLength), 4);
data.Eccentricity = round(str2double(data.Eccentricity), 4);
data.ConvexArea = round(str2double(data.ConvexArea), 4);
data.Extent = round(str2double(data.Extent), 4);
data.Class = cellfun(@string, data.Class);

out = data;
end