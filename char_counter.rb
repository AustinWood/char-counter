file_extension = "rb"

alphabet = {}
alphabet.default = 0

Dir.glob("corpus/**/*.#{file_extension}") do |file|

  puts "working on: #{file}"

  line_num = 0
  text = File.open(file).read
  text.gsub!(/\r\n?/, "\n")
  text.each_line do |line|
    print "#{line_num += 1} #{line}"

    letters = line.downcase.chars
    letters.each do |letter|
      alphabet[letter] +=1
    end

  end
end

p alphabet
