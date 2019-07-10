namespace :bacth do

  desc "task_every_day_history_creation"
  task :every_day_history_creation=> :environment do
    day = Date.today
    weekday = %w(sun mon tue wed thu fri sat)[day.wday]
    coming_user = User.includes(:irregular_visits).where("((use_#{weekday} = ?) or (irregular_visits.date = ? and  irregular_visits.coming = ?))", true, day, true).references(:irregular_visits)

    irr_noncoming_user =  User.joins(:irregular_visits).where(irregular_visits: {date: day, coming: false})
    target_user = coming_user - irr_noncoming_user

    user_histories = []
    target_user.each do |user|
      user_histories << UserHistory.new(user_id: user.id,date: day)
    end

    UserHistory.where(date: day).destroy_all
    UserHistory.import(user_histories)

    user_check_histories = []
    UserHistory.where(date: day).each do |uh|
      uh.user.user_checks.each do |uch|
        user_check_histories << UserCheckHistory.new(user_history_id: uh.id, user_check_id: uch.id, check_id: uch.check_id)
      end
    end


    UserCheckHistory.import(user_check_histories)




  end
end
