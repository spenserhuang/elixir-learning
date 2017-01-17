# This document showcases the basic operators in Elixir

# List of basic arithmetic operators
# +, -, *, /, div/2, rem/2


# Elixir provides ++ and -- to manipulate lists
[1, 2, 3] ++ [4, 5, 6]
# => [1, 2, 3, 4, 5, 6]
[1, 2, 3] -- [2]
# => [1, 3]


# String concatenation is can be done with <>
"hi" <> " there"
# => "hi there"


# Elixir provides three boolean operators: or, and, and not. They strictly expect booleans as their first argument
# Providing non-boolean will raise exceptions
true and true
# => true
false or is_atom(:hi)
# => true
1 and true
# => ** (ArgumentError) argument error: 1
true and 1
# => 1

# or and and are short circuit operators. They only execute one side if it is enough to determine the result
false and raise("This error will never be raised")
# => false
true or raise("This error will never be raised")
# => true

# Elixir also offers ||, &&, and ! (they stand for or, and, and not respectively) which accept arguments of all types
# All values other than false and nil are true
1 || true
# => 1
false || 11
# => 11
nil && 13
# => nil
true && 17
# => 17
!true
# => fasle
!1
# => fasle
!nil
# => true

# Use and, or and not when expecting booleans and ||, &&, and ! if expecting non-booleans


# Elixir also provides ==, !=, ===, !==, <=, >=, <, and > as comparison operators
1 == 1
# => true
1 != 2
# => true
1 < 2
# => true

# == and === differ in that the latter is sticter when comparing ints and floats
1 == 1.0
# => true
1 === 1.0
# => false


# Users can compare datatypes in Elixir in the following sorting order
# number < atom < reference < function < port < pid < tuple < map < list < bitstring
1 < :atom
# => true
