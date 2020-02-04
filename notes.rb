client = Twitter::REST::Client.new do |config|
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

def client.get_all_tweets(user)
  collect_with_max_id do |max_id|
    options = {count: 1, tweet_mode: "extended", include_rts: false}
    options[:max_id] = max_id unless max_id.nil?
    user_timeline(user, options)
  end
end

client.get_all_tweets("emil_graphics")

user_names = ['emil_graphics', 'BPD_GOD', 'bronzeagemantis']

user_names.each do |user_name|
  user = client.user(user_name)

  account = Account.find_or_create_by(
    twitter_id: user.id
  )

  account.update_attributes(
    name: user.name,
    screen_name: user.screen_name,
    twitter_id: user.id,
    url: user.url.to_s,
    profile_image_url: user.profile_image_url.to_s
  )
end

account = Account.last

tweets = client.get_all_tweets(account.screen_name)

tweets.each do |tw|
  tweet = Tweet.find_or_create_by(
    account: account,
    tweet_id: tw.id
  )

  tweet.update_attributes(
    favorite_count: tw.favorite_count,
    retweet_count: tw.retweet_count,
    full_text: tw.attrs[:full_text],
    url: tw.url.to_s,
    tweeted_at: tw.created_at
  )
end


