class Tweet
  include Mongoid::Document
  field :text, type: String

  belongs_to :account
end
