#debugging

#use traceback() to see which function the error occurred
#the functions are printed in reverse order

#example

f <- function(x) {
  r <- x-g(x)
  r
}
g <- function(y) {
  r <- y*h(y)
  r
}
h <- function(z) {
  r <- log(z)
    if (r < 10)
    r^2
    else
    r^3
  }

f(1)

traceback()
# The traceback() does not tell you where in the function the error occurred.
# In order to know which line causes the error, you may want to step through the function using debug()



#debug(fpkm_calc) flags the function for debugging
#allows you to step thru it line by line
#undebug(fpkm_calc) unflags the function


# Example: compute the sum of squared error
## Computer sum of squares
SS <-function (mu, x) {
  d <- x-mu
  d2 <-d^2
  ss<-sum(d2)
  }

## set seed to get reproducible results
set.seed(100)
x <- rnorm(100)

SS(1,x)
# [1] 202.5615

## Now let’s start debugging
debug(SS)
SS (1, x)
debugging in: SS(1, x)
debug: {
  d <- x – mu
  d2 <- d^2
  ss <- sum(d2)
  ss
  }

# Browse[1]>
# The result of debug() it presents the function “Browse[1]>”
# After you saw the Browse[1]>, you can do different things:
# Typing n executes the current line and prints the next one
# Typing c executes the result of the function without stopping
# Typing Q quits the debugging
# Typing where tells where you are in the function call stack
# Typing ls() to list all the object in the local environment
# Typing an object or print (<object name>) tells you current valve of the object.





#browser()

# Inserting a call to browser() in a function will pause the execution of a function at the point where browser() is called.

h <- function(z) {
  browser () ## a break point inserted here
  r<-log(z)
  if (r<10)
    r^2
  else
    r^3
  }

f(-1)




#trace()

# Calling trace() on a function allows the user to insert bits of code into a function
# The syntax for trace() is a bit strange -> better off using debug()



#testthat()

# To set up your package to use testthat, run:
usethis::use_testthat()
#usethis NOT devtools -> old tutorial
# 1. Create a tests/testthat directory.
# 2. Adds testthat to the Suggests field in the DESCRIPTION.
# 3. Creates a file tests/testthat.R that runs all your tests when R CMD check runs.




# Once you’re set up the workflow is simple:
# 1. Modify your code or tests.
# 2. Test your package with Ctrl/Cmd + Shift + T or devtools::test().
# 3. Repeat until all tests pass.
#
# The testing output looks like this:
# Expectation : ...........
# rv : ...
# Variance : ....123.45.

# Each line represents a test file. Each represents a passed test. Each number represents a failed test.
# The numbers index into a list of failures that provides more details:
#   1. Failure(@test-variance.R#22): Variance correct for discrete uniform rvs -----
#              VAR(dunif(0, 10)) not equal to var_dunif(0, 10)
#              Mean relative difference: 3



#more about tests:

# Tests are organized hierarchically:
# expectations are grouped into tests which are organized in files:

# expectation = describes expected result of a computation
#               a function that starts with expect_
#               first is actual result, second is what you would expect

# test = groups together expectations to test output from a function
#       created with test_that()

# file = groups together related tests
#       given a human readable name with context



#two tests for equality:

# * There are two basic ways to test for equality:
# expect_equal(), and expect_identical().
# expect_equal() is the most commonly used: it uses all.equal() to check for equality within a numerical tolerance:
# Example of expect_equal() function:

expect_equal(10, 10)
expect_equal(10, 10 + 1e-7)
expect_equal(10, 11)
## Error: 10 not equal to 11
## 10 - 11 == -1


# The objective of expect_identical test is if you want to test for exact equivalence,
# or need to compare a more exotic object like an environment you will use expect_identical()
# It’s built on top of identical()



#expect_match()

# The expect_match() matches a character vector against a regular expression.
# The optional all argument controls whether all elements or just one element needs to match.
# This is powered by grepl() (additional arguments like ignore.case = FALSE or fixed = TRUE are passed on down).

string <- ("Testing is fun!”)

expect_match(string, "Testing")

# Fails, match is case-sensitive

expect_match(string, "testing")
## Error: string does not match 'testing'. Actual value: "Testing is fun!"




#skip()
#skipping a test
#rather than throwing an error it simply prints an S in the output.

