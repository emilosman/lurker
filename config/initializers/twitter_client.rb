CLIENT = Twitter::REST::Client.new do |config|
  config.consumer_key        = "XtYb4bkw9gfLGFQLcx3HwDD9b"
  config.consumer_secret     = "4pAWh2uaEaVARYnfWmewHPsLmK5LJcKvwpb75xAyTIzViHlXfC"
  config.access_token        = "1099068037704155136-zuT7lvXvrSQBBx0rKDKlEpDPJAnjoC"
  config.access_token_secret = "dE0uHSWOGpyNhe5vvx1YwNIAkuTiKGtI4yRLmvD3cQO6A"
end

def collect_with_max_id(collection=[], max_id=nil, &block)
  response = yield(max_id)
  collection += response
  response.empty? ? collection.flatten : collect_with_max_id(collection, response.last.id - 1, &block)
end

def CLIENT.get_all_tweets(user)
  collect_with_max_id do |max_id|
    options = {count: 200, tweet_mode: "extended", include_rts: false}
    options[:max_id] = max_id unless max_id.nil?
    user_timeline(user, options)
  end
end
