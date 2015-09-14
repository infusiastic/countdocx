require 'rubygems'

require 'zip'

def count_characters(filename)
  Zip::File.open(filename) do |zipfile|
    entry = zipfile.glob('docProps/app.xml').first
    contents = entry.get_input_stream.read
    contents.match(%r{<CharactersWithSpaces>(\d+)</CharactersWithSpaces>})[1].to_i
  end 
end

if ARGV.size==0
	STDERR.puts "\u001B[31mNo input files given!\u001B[0m\nJust add file names as command line parameters."
else
  total_count = 0
  ARGV.each do |filename|
    begin
      characters_count = count_characters(filename)
      puts "#{filename}: \u001B[33m#{characters_count}\u001B[0m"
    rescue
      characters_count = 0
      puts "#{filename}: \u001B[31mNot a DocX file!\u001B[0m"
    end
    total_count += characters_count
  end
  puts '---'
  puts "Total characters: \u001B[33m#{total_count}\u001B[0m"
end