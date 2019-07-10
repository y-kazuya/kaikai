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

    def check_account_faclity(faclity)
      unless current_account || current_account.id == facility.account.id
        redirect_to root_path
      end
    end

    def chekc_item__facility(item)
      unless current_facility || current_facility.id == item.facility.id
        redirect_to root_path
      end
    end

    def check_auth_account_info(param_id = params[:id])
      if !current_account || current_account.id != param_id.to_i
        redirect_to root_path
      end
    end

end