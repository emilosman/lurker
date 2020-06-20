class Tweet
  include Mongoid::Document
  field :favorite_count, type: Integer
  field :retweet_count, type: Integer
  field :full_text, type: String
  field :tweet_id, type: String
  field :url, type: String
  field :tweeted_at, type: String
  field :tweeted_at, type: String
  field :read, type: Boolean, default: false
  field :starred, type: Boolean, default: false
  field :media, type: Array

  scope :starred, ->{ where(starred: true) }

  belongs_to :account
end
