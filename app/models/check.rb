class Check < ApplicationRecord
  belongs_to :facility, optional: true
  has_many :user_checks, dependent: :destroy
  has_many :users, through: :user_checks

  validate :uniqe_public


  enum kind: {
    ▼選択して下さい:  nil, テキストタイプ: 0, チェックボックス: 1
  }


  private
  def uniqe_public
    errors.add(:name, "同じ名前のタイプが存在します") if Check.where(public: true).where(title: title) != []
  end
end
