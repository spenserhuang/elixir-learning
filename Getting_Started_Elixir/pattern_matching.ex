# This document showcases how pattern matching is done in Elixir

# MATCH OPERATOR
# the = operator in Elixir is actually a match operator
x = 1
# => 1
x
# => 1
1 = x
# => 1
2 = x
# => (Match Error) no match of right hand side value: 1
1 = unknown
# => ** (CompileError) iex:1: undefined function unknown/0
# Variables can only be assigned to the left side of =



# PATTERN MATCHING

# We can use pattern matching to destructure more complex data types such as pattern matching tuples or lists
[a, b, c] = [1, 2, 3]
# => [1, 2, 3]
a
# => 1
{a, b, c} = {:hi, "hello", 3}
# => {:hi, "hello", 3}
a
# => :hi
b
# => "hello"
d = :hi
# => :hi
a = d
# => :hi
d = a
# => :hi
{a, b, c} = {:hi, "as"}
# => ** (MatchError) no match of right hand side value: {:hi, "as"}
{a, b, c} = [:hi, "as", 3]
# => ** (MatchError) no match of right hand side value: [:hi, "as", 3]
# Pattern matches return errors if the two sides can't be matched or when comparing different types

# We can match on specific values
{:ok, res} = {:ok, 13}
# => {:ok, 13}
res
# => 13
{:ok, res} = {:err, :oops}
# => ** (MatchError) no match of right hand side value: {:err, :oops}

# Lists also support matching on its head and tail
[head | tail] = [1, 2, 3]
# => [1, 2, 3]
head
# => 1
tail
# => [2, 3]
[h | t] = []
# => ** (MatchError) no match of right hand side value: []
# The user can't match empty lists with head and tail patterns

# Users can use [head | tail] to prepend items to lists too
list = [1, 2, 3]
# => [1, 2, 3]
[0 | list]
# => [0, 1, 2, 3]



# PIN OPERATOR

# Elixir variables can rebound
x = 1
# => 1
x = 2
# => 2

# Use the pin operator ^ to pattern match against an existing variable's value rather than rebinding the variable
x = 1
# => 1
^x = 2
# => ** (MatchError) no match of right hand side value: 2
{y, ^x} = {2, 1}
# => {2, 1}
y
# => 2
{y, ^x} = {2, 2}
# => ** (MatchError) no match of right hand side value: {2, 2}

# If a variable is mentioned more than once in a pattern, all references bind to the same pattern
{x, x} = {1, 1}
# => {1, 1}
{x, x} = {1, 2}
# => ** (MatchError) no match of right hand side value: {1, 2}

# If users don't care about particular values in a pattern, they can bind the values to the underscore _. Ex. If only the head matters, users can assign the tail to underscore
# Users cannot read from _ as it returns an unbound error
[h | _] = [1, 2, 3]
# => [1, 2, 3]
h
# => 1
_
# => ** (CompileError) iex:1: unbound variable _

# Pattern matching don't allow function calls on the left of the match