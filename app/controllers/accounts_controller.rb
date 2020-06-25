class AccountsController < ApplicationController
  before_action :get_account
  before_action :authenticate_user

  def index;end

  def new;end

  def create
    if params[:username]
      begin user = CLIENT.user(params[:username])
        account = Account.find_or_create_by(
          twitter_id: user.id
        )
        account.update_attributes(
          name: user.name,
          screen_name: user.screen_name,
          twitter_id: user.id,
          url: user.url.to_s,
          profile_image_url: user.profile_image_url.to_s,
          archived: false
        )
        account.fetch_tweets
        redirect_to account
      rescue
        Rails.logger.info "error"
      end
    end
  end
  
  def show
    @tweets = @account.tweets.chronological.page params[:page]
    @tweets.map{|a| a.update_attributes(read: true)}
    @account.update_attributes(
      unread_count: @account.tweets.where(read: false).count
    )
  end

  def update
    if @account
      if params[:archive]
        @account.update_attributes(archived: true)
        redirect_to accounts_path
      elsif params[:refresh_tweets]
        account.fetch_tweets
        redirect_to account
      end
    end
  end

  def starred
    @tweets = @account.tweets.chronological.starred.page params[:page]
    @tweets.map{|a| a.update_attributes(read: true)}
    @account.update_attributes(
      unread_count: @account.tweets.where(read: false).count
    )
    render 'show'
  end

  def unread
    @tweets = @account.tweets.chronological.unread.page params[:page]
    @tweets.map{|a| a.update_attributes(read: true)}
    @account.update_attributes(
      unread_count: @account.tweets.where(read: false).count
    )
    render 'show'
  end

  def media
    @tweets = @account.tweets.chronological.with_media.page params[:page]
    @tweets.map{|a| a.update_attributes(read: true)}
    @account.update_attributes(
      unread_count: @account.tweets.where(read: false).count
    )
    render 'show'
  end

  private
  def get_account
    @accounts = Account.published.all
    @account = Account.find(params[:id]) if params[:id]
  end

  def authenticate_user
    if Rails.env.production?
      authenticate_or_request_with_http_basic do |name, password|
        name == "test" && password == "lurker"
      end
    end
  end
end
