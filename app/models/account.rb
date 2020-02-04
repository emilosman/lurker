class Account
  include Mongoid::Document
  field :name, type: String
  field :screen_name, type: String
  field :twitter_id, type: String
  field :url, type: String
  field :profile_image_url, type: String
  field :unread_count, type: Integer

  has_many :tweets
end
