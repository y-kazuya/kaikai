class UserCheckHistory < ApplicationRecord
  belongs_to :user_history
  belongs_to :user_check, optional: true
  belongs_to :check

  validates :check_id, :uniqueness => {:scope => :user_history_id}


end
