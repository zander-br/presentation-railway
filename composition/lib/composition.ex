defmodule Composition do
  def convert_to_roman_numeral(decimal_number) do
    decimal_number
    |> parser_one_digit()
    |> parser_five_digit()
    |> parser_ten_digit()
    |> parser_fifty_digit()
    |> parser_hundred_digit()
    |> parser_five_hundred_digit()
    |> parser_thousand_digit()
    |> format_nine_hundred_digit()
    |> format_four_hundred_digit()
    |> format_ninety_digit()
    |> format_forty_digit()
    |> format_nine_digit()
    |> format_four_digit()
  end

  defp parser_one_digit(decimal_number) do
    Enum.to_list(1..decimal_number)
    |> Enum.map(fn _number -> "I" end)
    |> Enum.join("")
  end

  defp parser_five_digit(roman_number), do: String.replace(roman_number, ~r/I{5}/, "V")

  defp parser_ten_digit(roman_number), do: String.replace(roman_number, ~r/V{2}/, "X")

  defp parser_fifty_digit(roman_number), do: String.replace(roman_number, ~r/X{5}/, "L")

  defp parser_hundred_digit(roman_number), do: String.replace(roman_number, ~r/L{2}/, "C")

  defp parser_five_hundred_digit(roman_number), do: String.replace(roman_number, ~r/C{5}/, "D")

  defp parser_thousand_digit(roman_number), do: String.replace(roman_number, ~r/D{2}/, "M")

  defp format_nine_hundred_digit(roman_number), do: String.replace(roman_number, ~r/DC{4}/, "CM")

  defp format_four_hundred_digit(roman_number), do: String.replace(roman_number, ~r/C{4}/, "CD")

  defp format_ninety_digit(roman_number), do: String.replace(roman_number, ~r/LX{4}/, "XC")

  defp format_forty_digit(roman_number), do: String.replace(roman_number, ~r/X{4}/, "XL")

  defp format_nine_digit(roman_number), do: String.replace(roman_number, ~r/VI{4}/, "IX")

  defp format_four_digit(roman_number), do: String.replace(roman_number, ~r/I{4}/, "IV")
end
