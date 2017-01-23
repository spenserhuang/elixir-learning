# This document showcases binaries, strings, and char lists

# UTF-8 and UNICODE
# Strings are UTF-8 encoded binaries. Strings are a bunch of bytes organized in a way to represent certain code points
# The Unicode standard assigns code points to many characters we know

# Characters of code points above 255 need more than one byte to represent them Ex. ł has a code point of 322 and requires 2 bytes to represent it as shown through byte_size/1 and String.length/1 as byte_size/1 counts the underlying raw bytes and String.length/1 counts characters
string = "hełło"
# => "hełło"
byte_size(string)
# => 7
String.length(string)
# => 5

# You can get a character's code point by using ?
?a
# => 97
?ł
# => 322

# You can split a string into individual characters each as a string with length 1
String.codepoints("hełło")
# => ["h", "e", "ł", "ł", "o"]



# BINARIES & BITSTRINGS

# You can define a binary using <<>>
<<0, 1, 2, 3>>
# => <<0, 1, 2, 3>>
byte_size(<<0, 1, 2, 3>>)
# => 4

# Binaries are sequences of bytes and can be organized in any way
String.valid?(<<239, 191, 191>>)
# => false

# String concatenation is actually a binary concatenation operator
<<0, 1>> <> <<2, 3>>
# => <<0, 1, 2, 3>>
"hełło" <> <<0>>
<<104, 101, 197, 130, 197, 130, 111, 0>>
# A common trick is to concatenate the null byte <<0>> to a string to see its inner binary representations

# Each num given to a binary is meant to represent a byte and must go up to 255. We can convert a code point to UTF-8 representation though
<<255>>
# => <<255>>
<<256>>
# => <<0>>
<<256 :: size(16)>>
# => <<1, 0>>
# Use 16 bits (2 bytes) to store the number
<<256 :: utf8>>
# => À
# Number is a code point
<<256 :: utf8, 0>>
# => <<196, 128, 0>>
<<1 :: size(1)>>
# => <<1::size(1)>>
<2 :: size(1)>>
# => <<0::size(1)>>
# Truncated because we only pass a size of 1 bit
is_binary(<<1 :: size(1)>>)
# => false
is_bitstring(<<1 :: size(1)>>)
# => true
bit_size(<<1 :: size(1)>>)
# => 1
# The value is no longer a binary, but a bitstring.

# A binary is a bitstring where the number of bits is divisible by 8
is_binary(<<1 :: size(16)>>)
# => true
is_binary(<<1 :: size(15)>>)
# => false

# We can also pattern match on binaries and bitstrings
<<0, 1, x>> = <<0, 1, 2>>
# => <<0, 1, 2>>
x
# => 2
<<0, 1, x>> = <<0, 1, 2, 3>>
# => **(MatchError) no match of right hand side value: <<0, 1, 2, 3>>
<<0 , 1, x :: binary>> = <<0, 1, 2, 3>>
# => <<0, 1, 2, 3>>
x
# => <<2, 3>>
# Binary pattern is expected to match exactly 8 bits. If we want to match on a binary of unknown size, it is possible by using the binary modifier at the end of the pattern
"he" <> rest = "hello"
# => "hello"
rest
# => "llo"
# Similar results can be done with the string concatenation operator <>
# A string is a UTF-8 encoded binary and a binary is a bitstring where the number of bits is divisible by 8



# CHAR LISTS

# A char list is nothing more than a list of code points
# Char lists may be created with single-quoted literals
'hełło'
# => [104, 101, 322, 322, 111]
is_list('hełło')
# => true
'hello'
# => 'hello'
List.first('hello')
104
# Instaed of containing bytes, char lists contain code points of each character
to_charlist "hełło"
# => [104, 101, 322, 322, 111]
to_string 'hełło'
# => "hełło"
to_string :hello
# => "hello"
to_string 1
# => 1