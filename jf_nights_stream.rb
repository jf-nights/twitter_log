require 'tweetstream'

token = open('/home/jf712/.twitter/jf_nights').read.split("\n")

TweetStream.configure do |config|
  config.consumer_key       = token[0]
  config.consumer_secret    = token[1]
  config.oauth_token        = token[2]
  config.oauth_token_secret = token[3]
  config.auth_method = :oauth
end

client = TweetStream::Client.new

puts 'stream start!'
client.userstream do |status|
  puts status
end
