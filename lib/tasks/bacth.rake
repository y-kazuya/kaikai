namespace :bacth do

  desc "task_every_day_history_creation"
  task :every_day_history_creation=> :environment do
    today = Date.today
    weekday = %w(sun mon tue wed thu fri sat)[today.wday]
    weekday_user = User.where("use_#{weekday} = true")
    irr_coming_user = User.joins(:irregular_visits).where(irregular_visits: {date: today, coming: true})
    irr_noncoming_user =  User.joins(:irregular_visits).where(irregular_visits: {date: today, coming: false})
    has_today_history_user = User.joins(:user_histories).where(user_histories: {date: today})
    target_user = weekday_user - irr_noncoming_user + irr_coming_user - has_today_history_user

    user_histories = []
    target_user.each do |user|
      user_histories << UserHistory.new(user_id: user.id,date: today)
    end

    UserHistory.import user_histories


  end
end
