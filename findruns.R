
#use debugonce() to not have to unflag the function

# Calling the browser directly, rather than entering the debugger via
# debug() is very useful in situations in which you have a loop with many
# iterations and the bug surfaces only after, say, the 50th iteration.
# If the loop index is i, then you could write this:
  if (i > 49) browser()



setBreakpoint(filename,linenumber)
# This will result in browser() being called at line linenumber of our source file filename

# setBreakpoint() uses the trace() function
# to cancel the breakpoint, you cancel the trace.
# For instance, if we had called setBreakpoint() at a line in the function g(),
# we would cancel the breakpoint by typing the following:

untrace(g)



#tracking with trace()

trace(f,t)

# calls the function t() every time we enter the function f().
# For instance, say we wish to set a breakpoint at the beginning of the function gy().
# We could use this command:

trace(gy, browser)

#again, use untrace() to turn off

# You can turn tracing on or off globally by calling tracingState(),
# using the argument TRUE to turn it on or FALSE to turn it off.






#traceback()

# You can get a lot more information if you set up R to dump frames in the event of a crash:
options(error=dump.frames)


# You can arrange to automatically enter the debugger by:
options(error=recover)


# To turn off any of this behavior, type the following:
options(error=NULL)





#example

findruns <- function(x,k) {
  n <- length(x)
  runs <- NULL
  for (i in 1:(n-k)) {
     if (all(x[i:(i+k-1)]==1)) runs <- c(runs,i)
  }
  return(runs)
  }

findruns(c(1,0,0,1,1,0,1,1,1),2)
debug(findruns)




