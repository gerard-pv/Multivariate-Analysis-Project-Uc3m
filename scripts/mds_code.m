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
[n, p] = size(data);

numerical_data = data(:,1:9);
[n_num, p_num] = size(numerical_data);

binary_data = data(:,10);
[n_bin, p_bin] = size(binary_data);

categorical_data = data(:,11:17);
[n_cat, p_cat] = size(categorical_data);



%% Compute distance
D_gowers = gower2(data, 9, 1);
checkEuclideanCompatibility(D_gowers);

%% Compute MDS
[Y, ~, ~, ~] = coorp(D_gowers);
correlaciones2(data, Y, 9, 1, varNames);

%% PC1 most correlated vars
identif_cuantis(data(:,[7,8]), Y, varNames(:,[7,8]));
identif_cualis(data(:,[10,13,14]), Y, varNames(:,[10,13,14]));


%% PC2 most correlated vars
identif_cuantis(data(:,[7,8]), Y, varNames(:,[7,8]));
identif_cualis(data(:,17), Y, varNames(:,17));

%%
influence(data, 9, 1, varNames);

%%
sensitividad_Gower(data, 9, 1);


