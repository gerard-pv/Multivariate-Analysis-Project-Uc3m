% Purpose: Generate summary statistics for numerical and categorical variables.

%% Load Processed Data
load('data/matlab_datasets/processed_dataset.mat');

%% Display Summary of the Entire Dataset
disp('--- Overall Summary ---');
summary(data);

%% Summary of Numerical Variables
numeric_vars = data(:, vartype("numeric"));
disp('--- Summary of Numerical Variables ---');
summary(numeric_vars);

%% Summary of Categorical Variables
categorical_vars = data(:, vartype("categorical"));

disp('--- Summary of Categorical Variables ---');

for i = 1:width(categorical_vars)
    var_name = categorical_vars.Properties.VariableNames{i};
    fprintf('%s:\n', var_name);
    
    freq_table = tabulate(categorical_vars{:, i});
    
    disp(array2table(freq_table, 'VariableNames', {'Category', 'Count', 'Percentage'}));
    fprintf('\n');  % Add a newline between outputs for readability
end

