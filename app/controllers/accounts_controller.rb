class AccountsController < ApplicationController
  before_action :get_account

  def index;end

  def new;end

  def create
    if params[:username]
      user = CLIENT.user(params[:username])

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
  end
  
  def show
    @tweets = @account.tweets.page params[:page]
    @tweets.map{|a| a.update_attributes(read: true)}
    @account.update_attributes(
      unread_count: @account.tweets.where(read: false).count
    )
  end

  def starred
    @tweets = @account.tweets.starred.page params[:page]
    @tweets.map{|a| a.update_attributes(read: true)}
    @account.update_attributes(
      unread_count: @account.tweets.where(read: false).count
    )
    render 'show'
  end

  def unread
    @tweets = @account.tweets.unread.page params[:page]
    @tweets.map{|a| a.update_attributes(read: true)}
    @account.update_attributes(
      unread_count: @account.tweets.where(read: false).count
    )
    render 'show'
  end

  def media
    @tweets = @account.tweets.with_media.page params[:page]
    @tweets.map{|a| a.update_attributes(read: true)}
    @account.update_attributes(
      unread_count: @account.tweets.where(read: false).count
    )
    render 'show'
  end

  def refresh_tweets
    if account = Account.find(params[:id])
      account.fetch_tweets
    end
  end

  private
  def get_account
    @accounts = Account.all
    @account = Account.find(params[:id]) if params[:id]
  end
end
