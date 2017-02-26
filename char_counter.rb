file_extensions = %w(swift rb js)

blacklist = [
  *('A'..'Z'), # Exclude capital
  *('a'..'z'), # and lowercase letters.
  *('а'..'я'), # Cyrillic alphabet, too
  *('А'..'Я'),
  *('0'..'9'), # Numbers 0 through 9
  ' ', "\n"
]

alphabets = {}
file_extensions.each do |ext|
  alphabets[ext] = Hash.new(0)
end

file_extensions.each do |ext|

  Dir.glob("corpus/**/*.#{ext}") do |file|
    # puts "working on: #{file}"
    line_num = 0
    text = File.open(file).read
    text.gsub!(/\r\n?/, "\n")
    text.each_line do |line|
      # print "#{line_num += 1} #{line}"
      # letters = line.downcase.chars
      letters = line.chars
      letters.each do |letter|
        next if blacklist.include?(letter)
        alphabets[ext][letter] += 1
      end
    end
  end

end

puts "\nRaw character counts:"
puts "\n#{alphabets}\n\n"

alphabets.each do |name, letters|
  total = 0
  letters.each do |letter, count|
    total += count
  end
  puts "Total code chars in #{name} corpus: #{total}"

  sorted = alphabets[name].sort_by { |_key, value| value }.reverse.to_h

  sorted.each do |letter, count|

    weight = ((count.to_f / total.to_f) * 100.0)
    puts "#{letter}   #{count}    #{weight.round(3)}%"
    alphabets[name][letter] = weight
  end

  puts "\n"
end

final_count = {}
alphabets.each do |name, letters|
  final_count = final_count.merge(alphabets[name]){|key, oldval, newval| newval + oldval}
end

sorted = final_count.sort_by { |_key, value| value }.reverse.to_h

sorted.each do |letter, weight|
  adjusted_weight = weight / alphabets.count
  puts "#{letter}   #{adjusted_weight.round(3)}%"
end
