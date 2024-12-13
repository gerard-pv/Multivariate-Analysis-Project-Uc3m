function isEuclidean = checkEuclideanCompatibility(X)
    % CHECKEUCLIDEANCOMPATIBILITYWITHH Verifies if a matrix fulfills Euclidean compatibility.
    % Uses the centering matrix H for double centering.
    %
    % Input:
    %   X - A square distance or dissimilarity matrix
    % Output:
    %   isEuclidean - True if the matrix is Euclidean-compatible, False otherwise

    % Step 1: Verify if X is a square matrix
    [nRows, nCols] = size(X);
    if nRows ~= nCols
        error('Input matrix X must be square.');
    end

    % Step 2: Create the centering matrix H
    n = nRows;
    H = eye(n) - (1/n) * ones(n);

    % Step 3: Double-center the distance matrix using H
    B = -0.5 * H * X * H;

    % Step 4: Check positive semi-definiteness
    % Compute the eigenvalues of the centered matrix
    eigenvalues = eig(B);
    disp(min(eigenvalues));
    disp(min(eigenvalues) > 0);
    
