class Public::SessionsController < Public::ApplicationController
  before_action :non_logged_in_account , only: [:new, :create]


  def new
  end

  def create
    account = Account.find_by(email: params[:session][:email].downcase)
    if account && account.authenticate(params[:session][:password]) #存在するユーザーかつpasswordが一致
      log_in account
      params[:session][:remember_me] == '1' ? remember(account) : forget(account)
      redirect_back_or root_path
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in? #ログイン中のみログアウトバグ回避のため
    redirect_to root_url
  end
end
