class AccountsController < ApplicationController
  def index
    @accounts = Account.all
  end
  
  def show
    @accounts = Account.all
    @account = Account.find(params[:id])
    @tweets = @account.tweets.page(1)
  end
end
