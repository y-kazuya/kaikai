class User < ApplicationRecord
  mount_uploader :image, UserImageUploader
  belongs_to :facility
  has_many :emergency_contacts, dependent: :destroy
  has_many :notes, dependent: :destroy
  has_many :histories, dependent: :destroy

  has_many :user_checks, dependent: :destroy #多対多
  has_many :checks, through: :user_checks

  accepts_nested_attributes_for :user_checks

  accepts_nested_attributes_for :emergency_contacts
  accepts_nested_attributes_for :notes

  validates :name, presence: true, length: { maximum: 64 }

  validates :sex, inclusion: { in: ["男性", "女性"] }

  validates :use_mon,:use_tue,:use_wed,:use_thu,:use_fri,:use_sat,:use_sun,
              inclusion: { in: [true, false] }


  enum care_level: {
    ▼選択して下さい:  nil, 要介護度1: 1, 要介護度2: 2, 要介護度3: 3, 要介護度4: 4, 要介護度5: 5
  }

  def self.weeks
    {"月曜日": "mon", "火曜日": "tue", "水曜日": "wed", "木曜日": "thu", "金曜日": "fri", "土曜日": "sat", "日曜日": "sun"}
  end
end
