module SessionsHelper
 def log_in(account)
   session[:account_id] = account.id
 end

 def remember(account)
   account.remember
   cookies.permanent.signed[:account_id] = account.id
   cookies.permanent[:remember_token] = account.remember_token
 end

  # 現在ログイン中のユーザーを返す (いる場合)
  def current_account
   if (account_id = session[:account_id])
     @current_account ||= Account.find_by(id: account_id)
   elsif (account_id = cookies.signed[:account_id])
     account = Account.find_by(id: account_id)
     if account && account.authenticated?(:remember, cookies[:remember_token])
       log_in account
       @account = account
     end
   end
 end

 def logged_in?
   !current_account.nil?
 end

 # 永続的セッションを破棄する
 def forget(account)
   account.forget
   cookies.delete(:accountr_id)
   cookies.delete(:remember_token)
 end

 # 現在のユーザーをログアウトする
 def log_out
   forget(current_account)
   session.delete(:account_id)
   @current_account = nil
 end

 def current_account?(account)  #正しいユーザーかどうか検証してる
   account == current_account
 end

 # 記憶したURL (もしくはデフォルト値) にリダイレクト
 def redirect_back_or(default)
   redirect_to(session[:forwarding_url] || default)
   session.delete(:forwarding_url)
 end

 # アクセスしようとしたURLを覚えておく
 def store_location
   session[:forwarding_url] = request.original_url if request.get?
 end

end