class Api::UserCountsController < ApplicationController

  def index
    dates = (Date.parse(params["start"])..Date.parse(params["end"])).to_a
    target_day = dates[15]
    @sum = []
    class_name = "user_counts"
    dates.each do |day|
      next unless target_day.month == day.month
      title = "利用予定：#{current_facility.use_users(day).length}人"
      @sum << {start: day, title: title, class_name: class_name}
    end

    respond_to do |format|
      format.json
    end

  end
end
