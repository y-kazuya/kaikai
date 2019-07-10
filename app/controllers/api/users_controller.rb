class Api::UsersController < ApplicationController

  before_action :irr_date_check, only: [:add_irr_day]

  def serach
    @q = User.ransack(search_params)
    @users = @q.result(distinct: true)
    if search_params["date"]
      today = Date.today
      day = Date.parse(search_params["date"])

      @date = day
      if day > today
         @day_users = current_facility.use_users(search_params["date"], current_facility, false)
      else
         @day_users = current_facility.used_users(search_params["date"], current_facility, false)
      end
      @users = @day_users & @users
    end
    @users = revive_active_record(@users)

    respond_to do |format|
      return format.js { render "serach.js.erb" }
    end

  end

  def add_irr_day

    @user = User.find(params[:id])

    return redirect_to root_path if @user.facility != current_facility

    respond_to do |format|
      start_day = Date.parse(params["irr"]["start_date"])
      end_day =  start_day
      end_day = Date.parse(params["irr"]["end_date"]) unless params["irr"]["end_date"] == ""
      today = Date.today
      dates = (start_day..end_day)

      irregular_visits = []
      dates.each do |day|
        UserHistory.create(user_id: @user.id, date: today) if day == today
        d = IrregularVisit.new(irregular_visits_params)
        d.date = day
        irregular_visits << d
      end

      IrregularVisit.where(user_id: params[:id]).where(date: dates).destroy_all

      if IrregularVisit.import(irregular_visits)
        flash.now[:success] = params[:irr][:coming] ? "利用予定を追加しました。" : "未利用予定を追加しました。"
        # format.js { render "shared/flash.js.erb" }
        @user = User.find(params[:id])
        format.js {@user}
      else
        flash.now[:warning] = "フォームに誤りがあります"
        format.js { render "shared/flash.js.erb" }
      end


    end
  end

  private
  def search_params
    q = params.require(:search).permit!.merge(facility_id_eq: current_facility.id)
    q["#{q["forage"]}"] = params["search"].delete('age')
    q["#{q["weeks"].join("_or_") + "_true"}"]  = true if q["weeks"]
    return q
  end





  def irregular_visits_params
    params.require(:irr).permit(:coming).merge(user_id: params[:id].to_i)
  end



  def irr_date_check
    if params["irr"]["start_date"] == "" ###スタートデータなし
      flash.now[:warning] = "開始日を入力してください"
      return render "shared/flash.js.erb"
    end

    begin
      start_day = Date.parse(params["irr"]["start_date"])
      end_day =  start_day
      end_day = Date.parse(params["irr"]["end_date"]) unless params["irr"]["end_date"] == ""
      today = Date.today

    rescue
      flash.now[:warning] = "正しく日付を入力してください"
      return render "shared/flash.js.erb"
    end

    if start_day < today
      flash.now[:warning] = "過去の日付は登録できません"
      return render "shared/flash.js.erb"
    end

    if start_day == today && params["irr"]["coming"] == "false"
      flash.now[:warning] = "当日の未利用日の設定はできません。利用者一覧から、休みを選択してください"
      return render "shared/flash.js.erb"
    end

    dates = (start_day..end_day)

    if dates.to_a.size > 50
      flash.now[:warning] = "一度に登録できる期間は50日までです"
      return render "shared/flash.js.erb"
    end

    if start_day > end_day  ###終了が早い
      flash.now[:warning] = "開始日を終了日より早くする必要があります"
      return render "shared/flash.js.erb"
    end



  end


end
