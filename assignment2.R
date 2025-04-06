#remove all variables from environment
rm(list = ls())


# Tukey outlier detection function
tukey.outlier <- function(x) {
  q1 <- quantile(x, 0.25)
  q3 <- quantile(x, 0.75)
  iqr <- q3 - q1
  lower_bound <- q1 - 1.5 * iqr
  upper_bound <- q3 + 1.5 * iqr
  return(x < lower_bound | x > upper_bound)
}


# The code below contains a 'deliberate' bug!

# function to detect rows that are outliers in all columns

  tukey_multiple <- function(x) { # function takes one argument x, expected to be a matrix or df
    outliers <- array(TRUE,dim=dim(x)) # a new array named outliers
                                       # dim(x) gets the dimensions of the input matrix x
                                       # array(TRUE, dim=dim(x)) creates array the same size as x, filled with T values
                                          # bc we initially assume all values are outliers
    for (j in 1:ncol(x)) # iterates over each column in the matrix x
                         # ncol(x) returns # of cols in x, the loop will run once for each col of x
    {
      outliers[,j] <- outliers[,j] & tukey.outlier(x[,j]) # x[,j] extracts jth col of matrix x as a vector
                                                           # tukey.outlier(x[,j]) calculates which values in the jth col are outliers based on the Tukey method
                                                              # it returns a logical vector T for outliers and F for non-outliers
        # outliers[,j] -> jth col of outliers array
        # outliers[,j] & tukey.outlier(x[,j]) performs an element-wise logical AND
          # This means that the current values in outliers[,j] (whether they were previously considered outliers) will be updated based on whether the corresponding values in the column x[,j] are outliers.
          # If a value in x[, j] is not an outlier, it will remain FALSE in outliers[, j].
    }
    outlier.vec <- vector(length=nrow(x)) # store final results in outlier.vec
                                          # nrow(x) -> # of rows in x, so outlier.vec will have same length as the number of rows in x
    for (i in 1:nrow(x)) { # iterates over the rows of x and outliers
                           # nrow gives # of rows in x, so loop runs once for each row
      outlier.vec[i] <- all(outliers[i,]) # outliers[i,] extracts the i-th row of the outliers array, which contains TRUE or FALSE values for whether each column value in that row is an outlier.
                                          # all(outliers[i,]) checks if all the values in the i-th row of outliers are TRUE. If they are, it means that the row contains outliers in all columns
                                          # The result (TRUE or FALSE) is then stored in the i-th position of the outlier.vec vector. If TRUE, the row has outliers in all columns; if FALSE, it does not.
    }
    return(outlier.vec) # returns outlier.vec, which contains a logical vector of length equal to the number of rows in x.
                        # Each element of this vector is TRUE if the corresponding row in x has outliers in all columns, and FALSE otherwise.
    }

# Find the bug and fix it.




# Create a matrix with 5 columns and 4 rows of random values
x <- matrix(rnorm(20), ncol=5)  # 5 columns, 4 rows
print(x)  # Print the matrix to inspect the data


#tell R to flag the function for debugging
debug(tukey_multiple)

#call the function to open the debugger
outliers_result <- tukey_multiple(x)

undebug(tukey_multiple)

#load testthat()
install.packages("testthat")
library(testthat)


#use testthat()

test_that("tukey_multiple detects rows where all columns are outliers", {
  x <- matrix(c(
    1,   2,   3,
    100, 2,   3,
    1, 200,   3,
    1,   2, 300
  ), ncol = 3, byrow = TRUE)

  result <- tukey_multiple(x)
  expect_equal(result, c(FALSE, FALSE, FALSE, FALSE))  # Correct expectation
})


test_that("tukey_multiple works on random data without crashing", {
  set.seed(123)
  x <- matrix(rnorm(100), ncol=5)
  result <- tukey_multiple(x)
  expect_length(result, nrow(x))
  expect_type(result, "logical")
})

test_that("tukey_multiple returns all FALSE for non-outlier matrix", {
  x <- matrix(rep(1:5, each = 5), ncol = 5)
  result <- tukey_multiple(x)
  expect_false(any(result))  # Expect no row to be all outliers
})



#debugging the matrix

x <- matrix(c(
  1,   2,   3,
  100, 2,   3,
  1, 200,   3,
  1,   2, 300
), ncol = 3, byrow = TRUE)

x

#apply tukey.outlier() to each column
apply(x, 2, tukey.outlier)

# updated first testthat()


