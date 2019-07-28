# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


public_note_categories = ["食事", "介助","趣味趣向","親族・家族", "接し方"]

public_note_categories.each do |cate|
  NoteCategory.create(name: cate, public: true)
end

public_checks = [["排泄回数", 2], ["食事済", 1],["薬昼", 1],["薬夜", 1]]
piblic_common_checks = [
  ["体温",2],
  ["脈",2],
  ["血圧",2],
  ["体重",2],
  ["バイタル",2]
]


public_checks.each do |check|
  Check.create(title: check[0],kind: check[1] , public: true)
end

piblic_common_checks.each do |check|
  Check.create(title: check[0],kind: check[1] , public: true, common: true)
end





def ranran
  if rand(1..2) == 1
    return true
  else
    return false
  end
end


a_id = 1
a_id =Account.last.id if  Account.last

today = Date.today
s1 = Date.parse("2019/5/23")
s2 = Date.parse("2019/8/23")
dates = (s1..today)
weekday = %w(sun mon tue wed thu fri sat)


5.times do |a|
  a_id += 1
  account = Account.create(email: "tese#{a_id}@test.com", password: "111111")
  account.facility.update_attributes(name: "#{Faker::House.room},#{a_id}", tel: Faker::PhoneNumber.phone_number,email:Faker::Internet.email,pref: rand(1..47), city:Faker::Address.city, address: Faker::Address.street_address )

  checks = Check.where(public: true).to_a
  rand(1..11).times do
    checks << Check.create(title: Faker::Job.title, facility_id: account.facility.id , kind: rand(0..1), public: false)
  end

  note_categories = []
  rand(1..7).times do
    note_categories << NoteCategory.create(name: Faker::Restaurant.name , facility_id: account.facility.id, public: false)
  end

  rand(30..100).times do
    sex =""
    if ranran
      sex = "男性"
    else
      sex = "女性"
    end
    user = User.create(name: Faker::Name.name, sex: sex, care_level: rand(1..4),use_mon: ranran,use_tue: ranran,use_wed: ranran,use_thu: ranran,use_fri: ranran,use_sat: ranran,use_sun: ranran,use_random: ranran,facility_id: account.facility.id, age: rand(50..90),birth_year: rand(1900..1980),birth_month: rand(1..12),birth_day: rand(1..27))

    rand(0..3).times do
      EmergencyContact.create(name: "#{Faker::House.room},#{a}", tel: Faker::PhoneNumber.phone_number,email:Faker::Internet.email,pref: rand(1..47), city:Faker::Address.city, address: Faker::Address.street_address,relation: Faker::Ancient.god , user_id: user.id)
    end

    rand(0..5).times do
      Note.create(user_id: user.id, note_category_id: note_categories.sample.id, content: Faker::Lorem.word)
    end

    rand(0..checks.length).times do
      begin
        UserCheck.create(user_id: user.id, check_id: checks.sample.id)
      rescue
        next
      end
    end


    rand(0..10).times do
      day = Random.rand(s1 .. s2)
      coming = ""
      if day == today
        coming = true
      else
        coming = ranran
      end

      IrregularVisit.create(user_id: user.id, coming: coming, date: day)

      if day < today
        begin
          user_histroy = UserHistory.create(date: day,user_id: user.id, coming: ranran,content: Faker::Lorem.paragraph_by_chars )
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
          end
        rescue
          puts "error"
        end
      end

    end
  end
end


dates.each do |day|
  week = weekday[day.wday]
  users = User.where("use_#{week} = true")
  users.each do |user|
    begin
      user_histroy = UserHistory.create(date: day,user_id: user.id, coming: ranran,content: Faker::Lorem.paragraph_by_chars )
    rescue
      next
    end
  end
end