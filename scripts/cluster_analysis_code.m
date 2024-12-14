% Load the raw data
raw_data = readtable('data/matlab_datasets/processed_data');
varNames = raw_data.Properties.VariableNames;

% Remove the 'Revenue' column
raw_data_no_revenue = raw_data(:, setdiff(1:size(raw_data, 2), find(strcmp(varNames, 'Revenue'))));
varNames = raw_data_no_revenue.Properties.VariableNames;

% Display the first few rows of the data without 'Revenue' column
head(raw_data_no_revenue)

% Extract 'Revenue' column
revenue_group = raw_data.Revenue;

% Convert the data (without 'Revenue') to an array
data = table2array(raw_data_no_revenue);

% Number of rows to sample
numRows = 100;

% Generate random row indices
randomIndices = randperm(size(data, 1), numRows);
data = data(randomIndices, :);

[n, p] = size(data);

numerical_data = data(:,1:9);
[n_num, p_num] = size(numerical_data);

binary_data = data(:,10);
[n_bin, p_bin] = size(binary_data);

categorical_data = data(:,11:17);
[n_cat, p_cat] = size(categorical_data);

%%
d = gower(data, 9, 1);
U_min = linkage(d, "single");
U_max = linkage(d, "complete");
U_avg = linkage(d, "average");

cmin = cophenet(U_min, d);
cmax = cophenet(U_max, d);
cavg = cophenet(U_avg, d);

[cmin cmax cavg]


dendrogram(U_max, 0, "orientation", "left");

%%
d1 = robust2_maha(data(:, 1:9));
d2 = 2*(ones(n)-jaccard(data(:,10:11)));
d3 = 2*(ones(n)-coincidencias(data(:,11:end)));

vgeom1 = sum(sum(d1))/n^2;
vgeom2 = sum(sum(d2))/n^2;
vgeom3 = sum(sum(d3))/n^2;

D = d1/vgeom1 + d2/vgeom2 + d3/vgeom3;

d = D;

U_min = linkage(d, "single");
U_max = linkage(d, "complete");
U_avg = linkage(d, "average");

cmin = cophenet(U_min, d);
cmax = cophenet(U_max, d);
cavg = cophenet(U_avg, d);

[cmin cmax cavg]

dendrogram(U_max, 0, "orientation", "left");
