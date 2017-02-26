file_extension = "rb"
Dir.glob("corpus/**/*.#{file_extension}") do |file|
  puts "working on: #{file}"

  line_num = 0
  text = File.open(file).read
  text.gsub!(/\r\n?/, "\n")
  text.each_line do |line|
    print "#{line_num += 1} #{line}"
  end
end
