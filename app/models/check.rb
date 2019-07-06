class Check < ApplicationRecord
  belongs_to :facility, optional: true
  has_many :user_checks, dependent: :destroy
  has_many :checks, dependent: :destroy
  has_many :users, through: :user_checks
  has_many :user_check_histories, dependent: :destroy

  validates :title, presence: true

  validate :uniqe_public,on: :create
  validate :uniqe_in_facility,on: :create, if: lambda { !self.public }


  enum kind: {
    ▼選択して下さい:  nil, テキストタイプ: 0, チェックボックス: 1
  }


  private
  def uniqe_public
    errors.add(:name, "同じ名前のタイプが存在します") if Check.where(public: true).where(title: title) != []
  end

  def uniqe_in_facility
    errors.add(:name, "同じ名前のタイプが存在します。") if Check.where(facility_id: self.facility.id).where(title: title) != []
  end

  # def facility_public
  #   errors.add(:name, "同じ名前のタイプが存在します。") if Check.where(facility_id: self.facility.id).where(title: title) != []
  # end
end
