class UserCheck < ApplicationRecord
  belongs_to :check
  belongs_to :user

  has_many :check_histories, dependent: :destroy
end