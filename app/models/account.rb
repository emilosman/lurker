class Account
  include Mongoid::Document
  field :name, type: String
  field :screen_name, type: String
  field :twitter_id, type: String
  field :url, type: String
  field :profile_image_url, type: String
  field :unread_count, type: Integer

  has_many :tweets

  def fetch_tweets
    tweets = CLIENT.get_all_tweets(self.screen_name)

    tweets.each do |tw|
      tweet = Tweet.find_or_create_by(
        account: self,
        tweet_id: tw.id
      )

      tweet.update_attributes(
        favorite_count: tw.favorite_count,
        retweet_count: tw.retweet_count,
        full_text: tw.attrs[:full_text],
        url: tw.url.to_s,
        tweeted_at: tw.created_at,
        media: ( tw.media.map{|m| m.attrs[:media_url_https]} if tw.media.present? )
      )
    end
  end
end
