% pca_analysis.m
% Purpose: Perform PCA on standardized numerical variables and visualize results.

%% Load Processed Data
load('data/matlab_datasets/processed_dataset.mat');

%% Standardize Numerical Data for PCA
numeric_vars = data(:, vartype("numeric"));
numeric_data_matrix = table2array(numeric_vars);
standardized_data = (numeric_data_matrix - mean(numeric_data_matrix)) ./ std(numeric_data_matrix);

%% Compute PCA
[coeff, score, latent, ~, explained] = pca(standardized_data);

%% Scree Plot of Eigenvalues
figure;
bar(latent);
title('Scree Plot of Eigenvalues');
xlabel('Principal Component');
ylabel('Eigenvalue');
saveas(gcf, 'figures/pca_scree_plot.png', 'Resolution', 900);

%% Cumulative Variance Explained
cumulative_variance = cumsum(explained);
figure;
plot(cumulative_variance, '-o');
title('Cumulative Variance Explained by Principal Components');
xlabel('Number of Components');
ylabel('Cumulative Variance (%)');
saveas(gcf, 'figures/pca_cumulative_variance.png', 'Resolution', 900);

%% Display Loadings of Principal Components
disp('--- Principal Component Loadings ---');
disp(coeff);


