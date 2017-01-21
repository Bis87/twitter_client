require 'twitter'
require 'optparse'

options = {}

#Create our options

OptionParser.new do |opt|
  opt.banner = 'Usage: twitter.rb [options]'

  opt.on('-h', 'Show settings help')do
    puts opt
    exit
end

opt.on('--twit "TWIT"', 'twit twit') {|o| options[:twit] = o}
opt.on('--time_line USER_NAME', 'show last twits') {|o| options[:time_line] = o}
opt.on('--image PATH_TO_IMAGE', 'twit image') {|o| options[:image] = o}
opt.on('--quantity NUMBER', 'show number of twits') {|o| options[:quantity] = o}
end.parse!

client = Twitter::REST::Client.new do |config|
  config.consumer_key = 'YuMEAIlSgne4hcFv1NOAvKoq1'
  config.consumer_secret = 'cfxqIoq6QvTX2mwJL8Drxeo0C99beJljiJ54MMuCOPmmfVogAv'
  config.access_token = '821808995656667136-jvqL0cTOzkilPy59N0MunYf3bkrheso'
  config.access_token_secret = 'mYZDtdZ0A9UWgCAfw5PHWLNJcSm2P9vXaDTbCZq32jagQ'
end

puts "options[:number] = #{options[:number]}"

options[:number] = 5 unless options[:number]

def puts_twit(twits)
  twits.each do |twit|
    puts twit.text
    puts "by @#{twit.user.screen_name}, #{twit.created_at}"
    puts "-"*40
  end
end



if options.key?(:twit)
  puts "posting twit: #{options[:twit]}"
  client.update(options[:twit])
  puts 'Twit posted!'
end

if options.key?(false)

end

if options.key?(:time_line)

  # puts 'type quantity of twits to see'
  # ui = STDIN.gets.chomp.to_i



  puts "Users Line: #{options[:time_line]}"

  opts = {count: options[:quantity], include_rts: true}

  twits = client.user_timeline(options[:time_line], opts)

  puts_twit(twits)
else
  puts "Mine Line:"
  # puts "Mine Line:"

  # twits = client.home_timeline({count: 5})
  #
  # puts_twit(twits)
end

if options.key?(:image)

  puts "path: #{options[:image]}"

  if File.exist?(options[:image])
    client.update_with_media("", File.new("#{options[:image]}"))
    puts 'Twit posted!'
  else
    puts 'can`t find an image'
  end
end