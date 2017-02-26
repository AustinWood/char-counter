file_extension = "rb"
Dir.glob("corpus/**/*.#{file_extension}") do |file|
  puts "working on: #{file}"
end
