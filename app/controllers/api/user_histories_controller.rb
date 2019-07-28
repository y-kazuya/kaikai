class Api::UserHistoriesController < ApplicationController


  def update
    @user_history = UserHistory.find(params[:id])
    respond_to do |format|

      return format.html { redirect_back_or dashboard_account_path account } if @user_history.user.facility != current_facility
      if @user_history.update_attributes(user_history_params)
        flash.now[:success] = "本日の記録を更新しました。"
        format.html { redirect_to account_users_path @user_history.user.facility }
        format.js { render "shared/flash.js.erb" }
      else
        flash.now[:alert] = "フォームに誤りがあり更新できませんした。"
        format.html {}
        format.js { render "shared/flash.js.erb" }
      end
    end
  end

  def get_check_number_histroy
    #日付と値が必要
    user = User.find_by(id: params[:user_id])
    uchs = UserCheckHistory.includes(:user_history).where.not(number_content: nil).where("(user_histories.user_id = ?) and (check_id = ?)", user.id, params[:id]).references(:user_history)

    unless user || user.facility != current_facility
      return false
    end
    @dates = []
    @numbers = []
    @check = Check.find(params[:id])
    uchs.each do |uch|
      @dates << uch.user_history.date.strftime('%m/%d')
      @numbers << uch.number_content
    end
    respond_to do |format|
      format.json
    end
  end


  # format.html { redirect_back_or dashboard_account_path account }
  # format.js { render js: "window.location = '#{dashboard_account_path(account)}'" }


  private
    def user_history_params
      params.require(:user_history).permit(:content,:coming,
                                            user_check_histories_attributes: [:id, :text_content, :check_content, :number_content]
                                  )
    end

end
