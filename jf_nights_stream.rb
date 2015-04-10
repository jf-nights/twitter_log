require 'tweetstream'
require 'json'

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
  
  # 保存先
  log_path = "/home/jf712/local/log/twitter/#{Time.now.strftime("%Y.%m.%d.json")}"
  # 無かったら作る
  open(log_path, 'w').close if !File.exists?(log_path)

  # 保存してあるlog読み込み
  json_data = open(log_path) do |io|
    JSON.load(io)
  end
  # 無かったら作る
  json_data = [] if json_data == nil

  # なんかto_hしたらいい感じに見える
  json_data << status.to_h

  # 保存
  open(log_path, 'w') do |io|
    JSON.dump(json_data, io)
  end
  
end
