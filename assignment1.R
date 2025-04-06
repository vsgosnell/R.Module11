#remove all variables from environment
rm(list = ls())


#define tukey.outlier()
tukey.outlier <- function(x) {
  q1 <- quantile(x, 0.25)
  q3 <- quantile(x, 0.75)
  iqr <- q3 - q1
  lower_bound <- q1 - 1.5 * iqr
  upper_bound <- q3 + 1.5 * iqr
  return(x < lower_bound | x > upper_bound)
}




#intentionally buggy code

tukey_multiple <- function(x) {
  outliers <- array(TRUE,dim=dim(x))
  for (j in 1:ncol(x))
  {
    outliers[,j] <- outliers[,j] & tukey.outlier(x[,j])
  }
  outlier.vec <- vector(length=nrow(x))
  for (i in 1:nrow(x)) {
    outlier.vec[i] <- all(outliers[i,])
  }
  return(outlier.vec)
  }




# Create a matrix with 5 columns and 4 rows of random values
x <- matrix(rnorm(20), ncol=5)  # 5 columns, 4 rows
print(x)  # Print the matrix to inspect the data


#tell R to flag the function for debugging
debug(tukey_multiple)

#call the function to open the debugger
outliers_result <- tukey_multiple(x)

#turn off debugging
undebug(tukey_multiple)




#updated buggy code

tukey_multiple <- function(x) {
  outliers <- array(TRUE, dim=dim(x))  # Initialize outliers matrix
  for (j in 1:ncol(x)) {
    print(paste("Processing column", j))  # Debugging print
    print(outliers[, j])  # Before update
    print(tukey.outlier(x[, j]))  # Tukey outlier results for current column
    outliers[, j] <- outliers[, j] & tukey.outlier(x[, j])
    print(outliers[, j])  # After update
  }
  outlier.vec <- vector(length=nrow(x))
  for (i in 1:nrow(x)) {
    outlier.vec[i] <- all(outliers[i, ])
  }
  return(outlier.vec)
}




# Create a matrix with 5 columns and 4 rows of random values
x <- matrix(rnorm(20), ncol=5)  # 5 columns, 4 rows
print(x)  # Print the matrix to inspect the data


#tell R to flag the function for debugging
debug(tukey_multiple)

#call the function to open the debugger
outliers_result <- tukey_multiple(x)

#turn off debugging
undebug(tukey_multiple)



print(outliers_result)




# No outliers
x_no_outliers <- matrix(c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10), ncol=5)
outliers_result_no_outliers <- tukey_multiple(x_no_outliers)
print(outliers_result_no_outliers)  # Expect FALSE for all rows

# All outliers
x_all_outliers <- matrix(c(100, 200, 300, 400, 500, 600, 700, 800, 900, 1000), ncol=5)
outliers_result_all_outliers <- tukey_multiple(x_all_outliers)
print(outliers_result_all_outliers)  # Expect TRUE for all rows





