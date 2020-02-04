class AccountsController < ApplicationController
  def index
    @accounts = Account.all
  end
  
  def show
    @accounts = Account.all
    @account = Account.find(params[:id])
    @tweets = @account.tweets.page params[:page]

    @tweets.map{|a| a.update_attributes(read: true)}

    @account.update_attributes(
      unread_count: @account.tweets.where(read: false).count
    )
  end
end
