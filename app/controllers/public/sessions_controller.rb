class Public::SessionsController < Public::ApplicationController
  before_action :non_logged_in_account , only: [:new, :create]

  def new
  end

  def create
    account = Account.find_by(email: params[:session][:email].downcase)
    respond_to do |format|
      if account && account.authenticate(params[:session][:password]) #存在するユーザーかつpasswordが一致
        log_in account
        params[:session][:remember_me] == '1' ? remember(account) : forget(account)
        format.html { redirect_back_or dashboard_account_path account }
        format.js { render js: "window.location = '#{dashboard_account_path(account)}'" }
      else
        format.json { render json: {"fail_login": true}, status: :ok}
      end
    end
  end

  def destroy
    log_out if logged_in? #ログイン中のみログアウトバグ回避のため
    redirect_to root_url
    flash[:info] ="ログアウトしました。"
  end
end
