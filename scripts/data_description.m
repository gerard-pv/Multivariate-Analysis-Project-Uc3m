%% Import Preprocessed dataset

load('data/matlab_datasets/processed_dataset.mat');
head(data)

%% Overall summary

summary(data)

%% Numerical variables summary
numSubscript = vartype("numeric");
numeric_data = data(:, numSubscript);

summary(numeric_data)

%% Boxplots


num_vars = width(numeric_data);  
for i = 1:num_vars
    figure;
    sgtitle(['Distribution of ', numeric_data.Properties.VariableNames{i}]);

    subplot(1, 2, 1); 
    boxplot(numeric_data{:, i}, 'Orientation', 'horizontal');  % Create boxplot for the i-th variable

    subplot(1, 2, 2);  % Right side for histogram
    histogram(numeric_data{:, i}, 20);
end

%% Categorical Variables

catSubscript = vartype("categorical");
categorical_data = data(:, catSubscript)

num_vars = width(categorical_data);  
for i = 1:num_vars
    figure;
    sgtitle(['Distribution of ', categorical_data.Properties.VariableNames{i}]);

    current_var = categorical_data{:, i};

    subplot(1, 2, 1);
    category_counts = countcats(current_var);
    bar(category_counts);
    xticks(1:length(categories(current_var)));
    xticklabels(categories(current_var));
    title('Bar Plot of Categories');
    xlabel('Category');
    ylabel('Frequency');

    subplot(1, 2, 2);
    pie_counts = countcats(current_var);
    percentages = pie_counts / sum(pie_counts) * 100;
    
    explode_indices = find(percentages < 5);
    piechart(current_var, "ExplodedWedges", explode_indices);
end


%% Correlation matrix for numerical variables
numeric_data_matrix = table2array(numeric_data);
correlation_matrix = corr(numeric_data_matrix);

figure
plotmatrix(numeric_data_matrix);

figure;
h = heatmap(correlation_matrix);

h.XDisplayLabels = numeric_data.Properties.VariableNames;
h.YDisplayLabels = numeric_data.Properties.VariableNames;

title('Correlation Matrix Heatmap');
h.Colormap = jet;  
h.ColorLimits = [-1 1];
colorbar;
