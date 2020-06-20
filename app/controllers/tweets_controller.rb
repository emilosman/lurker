class TweetsController < ApplicationController
  def starred
    @tweets = Tweet.starred.page params[:page]

    @tweets.map{|a| a.update_attributes(read: true)}

    @accounts = Account.all

    render 'accounts/show'
  end

  def star
    if tweet = Tweet.find(params[:id])
      tweet.update_attributes(
        starred: !tweet.starred
      )
    end
  end
end
