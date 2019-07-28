namespace :jobs do

  desc "task_create_user_past_history"
  task :create_user_past_date=> :environment do
    today = Date.today
    s1 = today - 30
    dates = (s1..today)
    weekday = %w(sun mon tue wed thu fri sat)


    dates.each do |day|
      week = weekday[day.wday]
      coming_user = User.includes(:irregular_visits).where("((use_#{week} = ?) or (irregular_visits.date = ? and  irregular_visits.coming = ?))", true, day, true).references(:irregular_visits)

      irr_noncoming_user =  User.joins(:irregular_visits).where(irregular_visits: {date: day, coming: false})
      users = coming_user - irr_noncoming_user
      users.each do |user|

        if UserHistory.where(user_id: user.id,date: day).length == 0
          user_histroy = UserHistory.create(date: day,user_id: user.id, coming: rand(0..1),content: Faker::Lorem.paragraph_by_chars )

          user_histroy.user_check_histories.each do |u_c_h|
            user_check_id = UserCheck.find_by(user_id: user.id, check_id: u_c_h.check.id) || nil
            param = {user_history_id: user_histroy.id, check_id: u_c_h.check.id, user_check_id: user_check_id }
            if u_c_h.check.kind == 0
              param["text_content"] = Faker::Lorem.sentence(3, true)
            elsif u_c_h.check.kind == 1
              param["check_content"] = rand(0..1)
            else
              param["number_content"] = rand(70..190)

            end
            u_c_h.update_attributes(param)
          end
        end
      end

    end

  end
end