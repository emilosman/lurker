class TweetsController < ApplicationController
  def starred
    @tweets = Tweet.chronological.starred.page params[:page]

    @tweets.map{|a| a.update_attributes(read: true)}

    @accounts = Account.published.all.group_by(&:tags)

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
