// [[Rcpp::depends(RcppArmadillo)]]
#include <RcppArmadillo.h>

using namespace Rcpp;
using namespace arma;

// [[Rcpp::export]]
mat maha(const mat& X) {
  int n = X.n_rows;  // Number of observations
  int p = X.n_cols;  // Number of variables
  
  //Center the data by subtracting the mean of each column
  rowvec meanVec = mean(X, 0);  // Compute column means
  mat centered = X.each_row() - meanVec;  // Center the data
  
  //Compute the covariance matrix (using Armadillo's cov function)
  mat S = cov(centered);  // Covariance matrix
  
  //Compute the inverse of the covariance matrix
  mat invS = inv(S);  // Inverse of covariance matrix
  
  //Initialize the distance matrix D
  mat D = zeros<mat>(n, n);  // Initialize distance matrix with zeros
  
  //Calculate squared Mahalanobis distances
  for (int i = 0; i < n; ++i) {
    for (int j = i + 1; j < n; ++j) {
      rowvec diff = centered.row(i) - centered.row(j);
      D(i, j) = as_scalar(diff * invS * diff.t());  // Squared Mahalanobis distance
      D(j, i) = D(i, j);  // Symmetry
    }
  }
  
  return D;
}
