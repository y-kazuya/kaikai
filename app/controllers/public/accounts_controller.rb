class Public::AccountsController < Public::ApplicationController
  before_action :logged_in_account, only: [:edit, :update, :destroy,]

  before_action :correct_account,   only: [:edit, :update, :destroy]

  def new
    @account = Account.new
  end

  def show
    @account = Account.find(params[:id])
  end

  def create
    @account = Account.new(account_params)
    if @account.save
      flash[:info] = "できたよ！"
      log_in @account
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
    @account = Account.find(params[:id])
  end

  def update
    @account = Account.find(params[:id])
    if @account.update_attributes(account_params)
      flash[:success] = "Profile updated"
      redirect_to @account
    else
      render 'edit'
    end
  end

  def destroy
    Account.find(params[:id]).destroy
    flash[:success] = "Account deleted"
    redirect_to root_url
  end


  private

    def account_params
      params.require(:account).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    def correct_account
      @account = Account.find(params[:id])
      redirect_to(root_url) unless current_account?(@account)
    end
end
