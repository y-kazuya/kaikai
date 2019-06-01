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
      flash[:info] = "ようこそ！ アカウントの作成に成功しました! まずは施設情報を登録しましょう！"
      log_in @account

      redirect_to account_facilities_path @account
    else
      render 'new'
    end
  end

  def edit
    @account = Account.find(current_account.id)
  end

  def update
    @account = Account.find(current_account.id)
    if @account.update_attributes(account_params)
      flash[:success] = "アカウントの編集に成功しました"
      redirect_to edit_account_path(@account)
    else
      render 'edit'
    end
  end

  def destroy
    Account.find(current_account.id).destroy
    flash[:success] = "Account deleted"
    redirect_to root_url
  end

  def dashboard
  end


  private

    def account_params
      params.require(:account).permit(:email, :password,
                                   :password_confirmation)
    end

    def correct_account
      @account = Account.find(params[:id])
      redirect_to(root_url) unless current_account?(@account)
    end
end
