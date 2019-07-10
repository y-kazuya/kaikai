class Api::UserCountsController < ApplicationController

  def index
    dates = (Date.parse(params["start"])..Date.parse(params["end"])).to_a
    target_day = dates[15]
    @sum = []
    class_name = "user_counts"
    today = Date.today
    dates.each do |day|
      next unless target_day.month == day.month
      if today <= day
        title = "#{current_facility.use_users(day,current_facility,false).length}人利用予定"
        @sum << {start: day, title: title, class_name: class_name}

      else
        title = "#{current_facility.used_histories(day,current_facility,false).length}人利用"
        @sum << {start: day, title: title, class_name: class_name}
      end
    end

    respond_to do |format|
      format.json
    end

  end
end
