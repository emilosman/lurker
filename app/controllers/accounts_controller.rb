class AccountsController < ApplicationController
  before_action :get_account

  def index;end
  
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
