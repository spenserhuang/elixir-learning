defmodule Bob do
  def hey(input) do
    cond do
        String.last(input) == "?" ->
            "Sure."
        String.trim(input) == "" or String.length(input) == 0 ->
            "Fine. Be that way!"
        Enum.all?(to_charlist(input), fn(x) -> x < 65 end) ->
            "Whatever."
        String.upcase(input) == input ->
            "Whoa, chill out!"
        String.length(input) > 0 ->
            "Whatever."
    end
  end
end

