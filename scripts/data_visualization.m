% Purpose: Visualize numerical and categorical variables.

%% Load Processed Data
load('data/matlab_datasets/processed_dataset.mat');

%% Numerical Variable Distribution
numeric_vars = data(:, vartype("numeric"));
num_vars = width(numeric_vars);

for i = 1:num_vars
    var_name = numeric_vars.Properties.VariableNames{i};
    figure;

    % Boxplot
    subplot(1, 2, 1); 
    boxplot(numeric_vars{:, i}, 'Orientation', 'horizontal');
    title(['Boxplot of ', var_name]);

    % Histogram
    subplot(1, 2, 2);  
    histogram(numeric_vars{:, i}, 20);
    title(['Histogram of ', var_name]);
    
    % Save figure
    exportgraphics(gcf, ['figures/' var_name '_distribution.png'], 'Resolution', 900);
end

%% Categorical Variable Distribution
categorical_vars = data(:, vartype("categorical"));
num_cat_vars = width(categorical_vars);

for i = 1:num_cat_vars
    var_name = categorical_vars.Properties.VariableNames{i};
    figure;

    % Bar Plot
    subplot(1, 2, 1);
    category_counts = countcats(categorical_vars{:, i});
    bar(category_counts);
    title(['Bar Plot of ', var_name]);
    xticks(1:length(categories(categorical_vars{:, i})));
    xticklabels(categories(categorical_vars{:, i}));
    xlabel('Category');
    ylabel('Frequency');

    % Pie Chart
    subplot(1, 2, 2);
    piechart(categorical_vars{:, i}, 'DisplayOrder','descend',"ExplodedWedges", explode_indices);
    title(['Pie Chart of ', var_name]);

    % Save figure
    exportgraphics(gcf, ['figures/' var_name '_distribution.png'], 'Resolution', 900);
end
