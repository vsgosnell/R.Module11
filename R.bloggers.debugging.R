#  https://www.r-bloggers.com/2014/10/functions-and-debugging-in-r/


# We can create objects and view objects

i <- 1
n <- 5
n
  # [1] 5
i
  # [1] 1

# We can use functions to create objects and view those objects

x <- seq(3, n)
x
    # [1] 3 4 5


out <- vector(length = n, mode = "numeric")
out
      # [1] 0 0 0 0 0



# Since i is 1 we can assign a value, say 1,
# to position 1 of our vector

 out[ i] <- 1
 i <- 2
 out[ i] <- 1
 out
# [1] 1 1 0 0 0




 # In this for loop, i takes values 3 then 4 then 5.

   for (i in seq(3, n)) {
         out[ i] <- out[i - 1] + out[i - 2]
      }
 out
 # [1] 1 1 2 3 5
 # We have calculated the first 5 terms of the Fibonacci series



 # To define a function we specify the arguments in round brackets,
  # then the code to be executed in curly brackets.
  # We can use return to clarify which object is the output of the function.

  fibonacci <- function(n) {

    out <- NA
    if (n >2) {

  out <- vector(length = n, mode = "numeric")
     out[1:2] <- 1
    for (i in seq(3, n)) {
       out[ i] <- out[i - 1] + out[i - 2]
      }

     if (n == 2) { out <- c(1, 1) }

     if (n == 1) { out <- 1 }

  return(out)
    }
}



  fibonacci(n = 5)
 # [1] 1 1 2 3 5

fibonacci(n = 6)
 # [1] 1 1 2 3 5 8


# test 1 - check first five terms
test01 <- fibonacci(n = 5)
 all(test01 == c(1, 1, 2, 3, 5))
# [1] TRUE


 undebug(fibonacci)


# Sometimes arguments will not be handled by the code
  fibonacci(n = 2)
 # Error in out[ i] <- out[i - 1] + out[i - 2] : replacement has length zero





  # Debug the function

  debug(fibonacci)

  fibonacci(n = 2)
#   debugging in: fibonacci(n = 2)
#   debug at #1: {
#   out <- vector(length = n, mode = "numeric")
#   out[1:2] <- 1
#   for (i in seq(3, n)) {
#     out[ i] <- out[i - 1] + out[i - 2]
#   }
#   return(out)
#   }
# Browse[2]>
#   debug at #3: out <- vector(length = n, mode = "numeric")
# Browse[2]>
#   debug at #5: out[1:2] <- 1
# Browse[2]>
#   debug at #7: for (i in seq(3, n)) {
# out[ i] <- out[i - 1] + out[i - 2]
# }
# Browse[2]>
#   debug at #7: i
# Browse[2]>
#   debug at #9: out[ i] <- out[i - 1] + out[i - 2]
# Browse[2]>
#   debug at #7: i
# Browse[2]>
#   debug at #9: out[ i] <- out[i - 1] + out[i - 2]
# Browse[2]>
#   Error in out[ i] <- out[i - 1] + out[i - 2] : replacement has length zero



   # First, run our existing test(s)
  # test 1 - check first five terms
   test01 <- fibonacci(n = 5)
   all(test01 == c(1, 1, 2, 3, 5))
  # [1] TRUE
  # Great, it passed
  # Now write new tests to check the functionality we added

  # test 2 - small n
   test02 <- fibonacci(n = 2)
   all(test02 == c(1, 1))
  # [1] TRUE

   # test 3 - negative n
  test03 <- fibonacci(n = -1)
   is.na(test03)
  # [1] TRUE

