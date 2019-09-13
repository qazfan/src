#!/usr/local/bin/ruby -w

require 'open-uri'
require 'fileutils'
# require 'rb-readline'
# require 'pry'

petpage_input_file = File.open(ARGV[0], 'r')
petpage = petpage_input_file.read

photobucket_urls = petpage.
  scan(/http[s]?:\/\/[a-zA-Z0-9]*\.photobucket\.com[^><\"\')(]*\.(?:gif|jpg|png|jpeg|GIF|JPG|PNG|JPEG)/).
  uniq

puts photobucket_urls.join("\n")
puts "Are all the URLs photobucket links? y/N"
go = $stdin.gets
exit unless go.chomp.downcase == 'y'

petname = File.basename(petpage_input_file).split('.').first

photobucket_urls.each do |photobucket_url|
  path = "./#{petname}#{URI.parse(photobucket_url).path}"
  puts "PATH: #{path}"
  FileUtils.mkpath(path.split('/').first(path.split('/').size - 1).join('/'))
  cmd = "curl -o #{path} --referer \"https://s82.photobucket.com/\" #{photobucket_url}"
  puts cmd
  x = `#{cmd}`
  puts x
end


# petpage.gsub(/http[s]?:\/\/[a-zA-Z0-9]*\.photobucket\.com/, )
