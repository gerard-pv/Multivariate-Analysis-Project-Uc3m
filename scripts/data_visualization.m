% Purpose: Visualize numerical and categorical variables.

%% Load Processed Data
load('data/matlab_datasets/processed_dataset.mat');
numeric_vars = data(:, vartype("numeric"));
num_vars = width(numeric_vars);
numeric_data_matrix = table2array(numeric_vars);

%% Numerical Variable Distribution

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


%% Heatmap of Correlation Matrix

red = [1, 0, 0];      % RGB for red
white = [1, 1, 1];    % RGB for white

% Create a colormap with white on both ends and red in the middle
custom_colormap = [linspace(red(1), white(1), 50)', linspace(red(2), white(2), 50)', linspace(red(3), white(3), 50)';
                   linspace(white(1), red(1), 50)', linspace(white(2), red(2), 50)', linspace(white(3), red(3), 50)'];


correlation_matrix = corr(numeric_data_matrix);
figure;
heatmap(correlation_matrix, 'Colormap', custom_colormap, 'ColorLimits', [-1, 1]);
title('Correlation Matrix Heatmap');
saveas(gcf, 'figures/correlation_matrix_heatmap.png', 'Resolution', 900);