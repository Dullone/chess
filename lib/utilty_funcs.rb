def convert_input(string)
  input = string.split(",")
  input_array = [nil, nil]
  input_array[1] = (input[1].strip.to_i - 1)
  if @@alph_rows.include?(input[0].downcase)
    input_array[0] = @@alph_rows.index(input[0])
  else
    return false
  end
  if input_array[0] < 8 && input_array[1]  < 8
    puts "#{input_array}"
    return [input_array[1], input_array[0]] #reverse order
  end
  false
end

def conver_index_notation(index)
  if index[0] <= 8 && index[0] > 0 && index[1] > 0 && index[1] <= 8
    return :fuck_you
  end
  notation = ""
  notation << @@alph_rows[index[1]]
  notation << ", "
  notation << (index[0] + 1).to_s

  notation
end