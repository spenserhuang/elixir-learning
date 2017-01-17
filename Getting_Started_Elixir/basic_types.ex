# This document showcases some of the basic types used in Elixir
# note: function names will be followed by its arity such as round/1 which identifies a func called round which takes 1 argument

# Elixir basic types: integers, gloats, booleans, atoms, strings, lists, and tuples
# iex> 1          # integer
# iex> 0x1F       # integer
# iex> 1.0        # float
# iex> true       # boolean
# iex> :atom      # atom / symbol
# iex> "elixir"   # string
# iex> [1, 2, 3]  # list
# iex> {1, 2, 3}  # tuple

# Elixir also provides Port, Reference, and PID as more complex data types



# BASIC ARITHMETIC

1 + 2
# => 3
10 / 2
# => 5.0 (the operator / always returns a float)
div(10, 2)
# => 5
div 10, 2
# => 5
rem 10, 3
# => 1
# Integer division can be done with the div() function and remainders can be derived from the rem() function
# Note Elixir allows the user to drop parentheses when invoking named functions to provide cleanre syntax

0b1010
# => 10
0o777
# => 511
# Elixir also supports shorcut notation for entering binary, octal, and hex nums

1.0
# => 1.0
1.0e-10
# => 1.0e-10
# To get a float, the user must type a dot followed by at least one digit
# Elixir supports e for the exponent number
# Floats in Elixir are 64 bit double precision

round (3.58)
# => 4
trunc(3.58)
# 3
# round function gets the closest int to a given float
# trunc function gets the int part of the float



# BOOLEANS
# Elixir supports true and false as booleans

true
# true
true == false
# false
is_boolean(true)
# true
is_boolean(1)
# false
# Elixir provides many predicate functions to check value types such as is_integer/1, is_float/1, or is_number/1



# ATOMS
# Atoms are constants that uses its name as its value. They're often referred to as symbols in other languages such as Ruby

:hello
# => :hello
:hello == :world
# => false
true == :true
# => true
is_atom(false)
# true
is_boolean(:false)
# true
# The booleans true and false are actually atoms



# STRINGS
# Strings in Elixir are inserted between double quotes and are encoded in UTF-8

"hellö"
# => "hellö"
"hellö #{:world}"
# => "hellö world"
# Elixir supports string interpolation

"hello
world"
# => "hello\nworld"
"hello\nworld"
# => "hello\nworld"
# Strings can have line breaks in them and they can also be introduced through escape sequences

IO.puts "hello\nworld"
# => hello
# => world
# => :ok
# Print strings with IO.puts/1 from the IO module
# IO.puts/1 returns the atom :ok after executing

is_binary("hellö")
# => true
# Elixir strings are internally represented as binaries

byte_size("hellö")
# => 6
# You can also get the number of bytes in a string

String.length("hellö")
# => 5
String.upcase("world")
# => "WORLD"
# The String module contains many more functions that can be operated on strings
# https://hexdocs.pm/elixir/String.html



# ANONYMOUS FUNCTIONS
# Anonymous functions can be created inline and are delimited by the keywords fn and end

add = fn a, b -> a + b end
# => Function<12.52032458/2 in :erl_eval.expr/5>
add.(1, 2)
# => 3
is_function(add)
# => true
is_function(add, 2)
# => true
is_function(add, 1)
# => false
# The user can add a second argument to is_function to check the arity of the func
# Functions are first class citizens in Elixir which means they can be passed as arguments to other functions
# A dot (.) is needed between the variable and the parthenses to invoke anynomous funcs to clarify whether the func is an anonymous func or a named func

double = fn a -> add.(a, a) end
# => Function<6.71889879/1 in :erl_eval.expr/5>
double.(2)
# => 4
# Anynomous funcs are closures and can access variables that are in scope when the func is defined

x = 42
# => 42
(fn -> x = 0 end).()
# => 0
x
# => 42
# Variables in funcs cannot affct its surrounding environment



# (LINKED) LISTS
# Elixir uses square brackets to specify a list of values. Values can be of any type

[1, 2, true, 3]
# => [1, 2, true, 3]
length[1, 3, true]
# => 3
[1, 2, 3] ++ [4, 5, 6]
# => [1, 2, 3, 4, 5, 6]
[1, true, 2, false, 3, true] -- [true, false]
# => [1, 2, 3, true]
# There are many functions that can be invoked on lists
# https://hexdocs.pm/elixir/List.html

list = [1, 2, 3]
hd(list)
# => 1
tl(list)
# => [2, 3]
hd []
# => ** (ArgumentError) argument error
# Getting  the head or tail of an empty list throws errors
# Head is the first element of a list and tail is the remainder of the list. They can be retrieved with hd/1 and tl/1
# Heads and tails are especially useful in Elixir because Elixir stores lists as linked lists

[11, 12, 13]
# => '\v\f\r'
[104, 101, 108, 108, 111]
# => 'hello'
# When Elixir sees a list of printable ASCII nums, it will print that as a char list
# Single quote and double quote representations are not equivalent in Elixir

list = [1 | [2 | 3 | []]]
# => [1, 2, 3]
[0 | list]
# => [0, 1, 2, 3]
# Lists are stored in memory as linked lists which means that each element in a list holds its value and poitns to the next element until the end of the list
# Each pair of value and pointer is known as a "cons cell"
# Updating a list is fast as long as we are prepending elements
# Accessing the length of a list is a linear operation as we need to go through the whole list to get the length


# TUPLES
# Elixir uses curly braces to define tuples. Tuples store elements contiguously in memory so accessing tuples elements by indexes or getting tuple size is very fast
# Getting the tuple size or accessing specific indexs is fast
# Updating or adding elements is expensive because it requires copying the entire tuple in memory
# Indexes start from zero

{:ok, "hello", 3}
# => {:ok, "hello", 3}
tuple_size{:ok, 2, "hi"}
# => 3
tuple = {:ok, 2, "hi"}
# => {:ok, 2, "hi"}
elem(tuple, 1)
# => 2
tuple_size(tuple)
# => 3
put_elem(tuple, 1, "world")
# => {:ok "world", "hi"}
tuple
# => {:ok 2, "hi"}
# Again, there are many function operations that can be used on tuples
# http://elixir-lang.org/docs/stable/elixir//Tuple.html
# Note that put_elem/3 returned a new tuple. The original tuple in the tuple variable was not changed because Elixir datatypes are immutable
