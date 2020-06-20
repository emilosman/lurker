class TweetsController < ApplicationController
  def star
    if tweet = Tweet.find(params[:id])
      tweet.update_attributes(
        starred: !tweet.starred
      )
    end
  end
end
