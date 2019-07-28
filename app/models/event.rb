class Event < ApplicationRecord
  belongs_to :facility
  has_many :events_users, dependent: :destroy #多対多
  has_many :users, through: :events_users

  accepts_nested_attributes_for :events_users
  # enum kind: {
  #   ▼選択して下さい:  nil, 娯楽イベント: 0, チェックボックス: 1, 数値タイプ: 2
  # }
end
