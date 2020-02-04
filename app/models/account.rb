class Account
  include Mongoid::Document
  field :name, type: String
  field :screen_name, type: String
  field :twitter_id, type: String
  field :url, type: String
  field :profile_image_url, type: String

  has_many :tweets
end
