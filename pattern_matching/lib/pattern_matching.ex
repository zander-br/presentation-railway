defmodule PatternMatching do
  def calculate(file) do
    file
    |> File.read()
    |> process_file()
  end

  defp process_file({:ok, data}) do
    data
    |> String.split("\n")
    |> Stream.map(&String.split(&1, ","))
    |> Stream.filter(&is_student?/1)
    |> Stream.map(&parse_student/1)
    |> Enum.map(&check_student_status/1)
  end

  defp process_file({:error, _reason}), do: {:error, "Falha ao processar arquivo"}

  defp is_student?(["Name" | _]), do: false
  defp is_student?(_), do: true

  defp parse_student([name, grade]), do: %{name: name, grade: String.to_float(grade)}

  defp check_student_status(%{grade: grade} = student) when grade >= 7.0 do
    Map.put(student, :status, "aprovado")
  end

  defp check_student_status(student) do
    Map.put(student, :status, "reprovado")
  end
end
