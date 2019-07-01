class Api::SessionsController < ApplicationController

  # def new
  #   @account = Account.find_by(email: params[:session][:email].downcase)
  #   @id = 0
  #   if @account && @account.authenticate(params[:session][:password]) #存在するユーザーかつpasswordが一致
  #     log_in @account
  #     params[:session][:remember_me] == '1' ? remember(@account) : forget(@account)
  #     # redirect_back_or dashboard_account_path @account
  #     @id = 1
  #     respond_to do |format|
  #       format.html redirect_back_or dashboard_account_path @account
  #     end
  #   end
  #   respond_to do |format|
  #     format.json {render :json => @id}
  #   end
  # end
end
