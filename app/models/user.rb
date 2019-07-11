class User < ApplicationRecord
  mount_uploader :image, UserImageUploader
  belongs_to :facility
  has_many :emergency_contacts, dependent: :destroy
  has_many :notes, dependent: :destroy
  has_many :histories, dependent: :destroy
  has_many :irregular_visits, dependent: :destroy
  has_many :user_histories, dependent: :destroy
  has_many :user_checks, dependent: :destroy #多対多
  has_many :checks, through: :user_checks

  accepts_nested_attributes_for :user_checks
  accepts_nested_attributes_for :emergency_contacts, reject_if: :rejec_ema
  accepts_nested_attributes_for :notes, reject_if: :rejec_note


  after_save :create_today_history

  validates :name, presence: true, length: { maximum: 64 }
  validates :sex, inclusion: { in: ["男性", "女性"] }
  validates :use_mon,:use_tue,:use_wed,:use_thu,:use_fri,:use_sat,:use_sun,
              inclusion: { in: [true, false] }
  validates :care_level, presence: true
  validate :need_weeks



  enum care_level: {
    ▼選択して下さい:  nil, 要介護度1: 1, 要介護度2: 2, 要介護度3: 3, 要介護度4: 4, 要介護度5: 5
  }

  scope :with_info, -> { includes({notes: :note_category}, {user_checks: [:check, :user_check_histories]},{user_histories: :user_check_histories}) }




  def self.weeks
    {"月曜日": "mon", "火曜日": "tue", "水曜日": "wed", "木曜日": "thu", "金曜日": "fri", "土曜日": "sat", "日曜日": "sun","不規則": "random"}
  end

  def use_weekday_day?(day = Date.today, q = true)
    begin
      day = Date.parse(day) unless day.class == Date
    rescue
      return false
    end
    day -= 1 if q && Time.now.hour == 0 && Time.now.min < 31
    weekday = %w(sun mon tue wed thu fri sat)[day.wday]
    today_use = eval "self.use_#{weekday}"
    return today_use
  end

  def has_today_date?
    today = Date.today
    today -= 1 if Time.now.hour == 0 && Time.now.min < 31
    return true if self.user_histories.last && self.user_histories.last.date == today
    return false
  end

  def today_date
    today = Date.today
    today -= 1 if Time.now.hour == 0 && Time.now.min < 31
    return self.user_histories.last if self.user_histories.last && self.user_histories.last.date == today
    return false
  end

  def future_irregular_visits(coming = true)
    today = Date.today
    today -= 1 if Time.now.hour == 0 && Time.now.min < 31

    return IrregularVisit.where(user_id: self.id, coming: coming).where("date >= ?", today)
  end

  def past_used?(date)
    self.user_histories.each {|u_h| return true if u_h.date == date }
    return false
  end

  def past_use_date(date)
    self.user_histories.each {|u_h| return u_h if u_h.date == date }
    return []
  end

  # def use_day?(day = Date.today)
  #   weekday = %w(sun mon tue wed thu fri sat)[day.wday]
  #   weekday_facility_user = self.users.where("use_#{weekday} = true")
  #   irr_coming_user = self.users.joins(:irregular_visits).where(irregular_visits: {date: day, coming: true})
  #   irr_noncoming_user =  self.users.joins(:irregular_visits).where(irregular_visits: {date: day, coming: false})
  #   @users = weekday_facility_user - irr_noncoming_user + irr_coming_user

  # end

  private


    def rejec_note(attributed)
      attributed['content'].blank?
    end

    def rejec_ema(attributed)
      attributed['name'].blank?
    end

    def rejec_checks(attributed)
      attributed['title'].blank?
    end

    def need_weeks
      if !use_mon&& !use_tue && !use_wed && !use_thu && !use_fri && !use_sat && !use_sun && !use_random
        errors.add(:use_mon,"曜日のいずれかは選択してください")
      end
    end

    def create_today_history

      today = Date.today
      today -= 1 if Time.now.hour == 0 && Time.now.min < 31
      weekday = %w(sun mon tue wed thu fri sat)[today.wday]
      today_use = eval "self.use_#{weekday}"
      if today_use == true && !self.has_today_date?
        UserHistory.create(user_id: self.id,date: today)
      end

    end



end
