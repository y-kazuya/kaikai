class UserHistory < ApplicationRecord
  belongs_to :user

  has_many :user_check_histories, dependent: :destroy

end
