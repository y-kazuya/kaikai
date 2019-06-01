class Public::ApplicationController < ApplicationController


  private
    def logged_in_account #ログインしてなかったらログイン画面へリダイレクト
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to new_session_path
      end
    end

    def non_logged_in_account #ログインしてたらルートへ
      if logged_in?
        flash[:danger] = "ログイン済みです"
        redirect_to root_path
      end
    end

end