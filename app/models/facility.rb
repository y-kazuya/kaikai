class Facility < ApplicationRecord
  mount_uploader :image, FacilityImageUploader
  belongs_to :account
  has_many :users, dependent: :destroy
  has_many :note_categories, dependent: :destroy
  has_many :checks, dependent: :destroy
  has_many :events, dependent: :destroy

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_URL_REGEX = /\Ahttp(s)?:\/\/([-\w]+\.)+[-\w]+(\/[-\w.\/?%&=]*)?/

  validates :email, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false },allow_blank: true


  validates :url, length: { maximum: 255 },
                  format: { with: VALID_URL_REGEX },
                  allow_blank: true

  validates :name, presence: true,
                   uniqueness: { case_sensitive: false } ,
                   length: { maximum: 252 }

  validates :city,:address,:tel,
            length: { maximum: 255 },allow_blank: true

  enum pref: {
    ▼選択して下さい:  nil,
    北海道:1,青森県:2,岩手県:3,宮城県:4,秋田県:5,山形県:6,福島県:7,
    茨城県:8,栃木県:9,群馬県:10,埼玉県:11,千葉県:12,東京都:13,神奈川県:14,
    新潟県:15,富山県:16,石川県:17,福井県:18,山梨県:19,長野県:20,
    岐阜県:21,静岡県:22,愛知県:23,三重県:24,
    滋賀県:25,京都府:26,大阪府:27,兵庫県:28,奈良県:29,和歌山県:30,
    鳥取県:31,島根県:32,岡山県:33,広島県:34,山口県:35,
    徳島県:36,香川県:37,愛媛県:38,高知県:39,
    福岡県:40,佐賀県:41,長崎県:42,熊本県:43,大分県:44,宮崎県:45,鹿児島県:46,沖縄県:47
  }



  def use_users(day = Date.today, facility = self, q = true)
    begin
      day = Date.parse(day) unless day.class == Date
    rescue
      return []
    end
    day -= 1 if q && Time.now.hour == 0 && Time.now.min < 31
    weekday = %w(sun mon tue wed thu fri sat)[day.wday]
    coming_user = self.users.includes(:irregular_visits).where("((use_#{weekday} = ?) or (irregular_visits.date = ? and  irregular_visits.coming = ?))", true, day, true).references(:irregular_visits)

    irr_noncoming_user =  self.users.joins(:irregular_visits).where(irregular_visits: {date: day, coming: false})
    @users = coming_user - irr_noncoming_user
  end

  def used_histories(day = Date.today, facility = self, q = true)
    begin
      day = Date.parse(day) unless day.class == Date
    rescue
      return []
    end
    day -= 1 if q && Time.now.hour == 0 && Time.now.min < 31

    @user_histories = UserHistory.includes(:user).where("(users.facility_id = ?) and (date = ?) and (coming = ?)", facility.id, day, true).references(:users)
  end

  def used_users(day = Date.today, facility = self, q = true)
    begin
      day = Date.parse(day) unless day.class == Date
    rescue
      return []
    end
    day -= 1 if q && Time.now.hour == 0 && Time.now.min < 31
    @users = User.includes(:user_histories).where("(facility_id = ?) and (user_histories.date = ?) and (user_histories.coming = ?)", facility.id, day, true).references(:user_histories)
  end





end
