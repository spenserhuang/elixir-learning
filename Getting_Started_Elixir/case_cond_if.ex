# This document showcases the case, cond, and if control flow structures

# CASE

# case allows us to compare a value against any patterns until one fits the case
case {1, 2, 3} do
    {4, 5, 6} ->
        "This clause won't match"
    {1, x, 3} ->
        "This clause will match and bind x to 2 in this clasue"
    _ ->
        "This clause would match any value"
end
# => "This clause will match and bind x to 2 in this clause"

# To pattern match against existing variables, we need to use the ^ operator
x = 1
case 10 do
    ^x -> "Won't match"
    _ -> "Will match"
end
# => "Will match"

# Clauses allow extra conditions to be specified via guards
case {1, 2, 3} do
    {1, x, 3} when x > 0 ->
        "Will match"
    _ ->
        "Would match, if guard condition fails"
end
# => "Will match"

# The following expressions are allowed in guard clauses
# comparison operators (==, !=, ===, !==, >, >=, <, <=)
# boolean operators (and, or, not)
# arithmetic operations (+, -, *, /)
# arithmetic unary operators (+, -)
# the binary concatenation operator <>
# the in operator as long as the right side is a range or a list
# all the following type check functions:
    # is_atom/1
    # is_binary/1
    # is_bitstring/1
    # is_boolean/1
    # is_float/1
    # is_function/1
    # is_function/2
    # is_integer/1
    # is_list/1
    # is_map/1
    # is_nil/1
    # is_number/1
    # is_pid/1
    # is_port/1
    # is_reference/1
    # is_tuple/1
# plus these functions:
    # abs(number)
    # binary_part(binary, start, length)
    # bit_size(bitstring)
    # byte_size(bitstring)
    # div(integer, integer)
    # elem(tuple, n)
    # hd(list)
    # length(list)
    # map_size(map)
    # node()
    # node(pid | ref | port)
    # rem(integer, integer)
    # round(number)
    # self()
    # tl(list)
    # trunc(number)
    # tuple_size(tuple)

# Users may also define their own guards
# Note that though and, or, and not are allowed in guards, &&, ||, and ! are not

# Errors in guards do not leak but make the guard fail
hd(1)
# => ** (ArgumentError) argument error
case 1 do
    x when hd(x) -> "Won't match"
    x -> "Got #{x}"
end
# => "Got 1"

# If no clauses match, error is raised
case :ok do
    :error -> "Won't match"
end
# => ** (CaseClauseError) no case clause matching: :ok

# Anonymous functions can also have many clauses and guards
# The number of arguments in each calsue needs to be the same otherwise errors will be raised
f = fn
    x, y when x > 0 -> x + y
    x, y -> x * y
end
# => Function<12.71889879/2 in :erl_eval.expr/5>
f.(1, 3)
# => 4
f.(-1, 3)
# => -3



# COND

# case is useful for matching against values. However we may use cond to check different conditions and find the first one that is true
cond do
    2 + 2 == 5 ->
        "This will not be true"
    2 * 2 == 3 ->
        "Nor this"
    1 + 1 == 2 ->
        "But this will"
end
# => "But this will"

# If no conditions return true, an error (CondClauseError) is raised, thus at times we may add a final condition equal to true that will always match
cond do
    2 + 2 == 5 ->
        "This is never true"
    2 * 2 == 3 ->
        "Nor this"
    true ->
        "This is always true (equivalent to else)"
end
# => "This is always true (equivalent to else)"

# cond considers anything other than nil and false to be true
cond do
    hd([1, 2, 3]) ->
        "1 is considered as true"
end
# => "1 is considered as true"



# IF & UNLESS

# Elixir also provides the macros if/2 and unless/2 that are useful for checking single conditions
if true do
    "This works!"
end
# => "This works!"
unless true do
    "This will never be seen"
end
# => nil
# nil is returned if the condition of if/2 or unless/2 does not fulfill and the body will not be executed

# Else blocks are also supported
if nil do
    "This won't be seen"
else
    "This will"
end
# => "This will"

# We can also write if without do/end blocks
if true, do: 1 + 2
# => 3
if false, do: :this, else: :that
# => :that



# DO/END

# do/end blocks do not require commas between the previous argument and the blocks
if true do
    a = 1 + 2
    a + 10
end
# => 13
if true, do: (
    a = 1 + 2
    a + 10
)
# => 13

# do/end blocks are always bound to the outermost function call
is_number if true do
    1 + 2
end
# => ** (CompileError) undefined function: is_number/2
is_number(if true do
    1 + 2
end)
# => true