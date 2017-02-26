file_extensions = %w(swift rb)

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
        alphabets[ext][letter] += 1
      end
    end
  end

end

p alphabets
puts "\n"
