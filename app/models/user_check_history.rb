class UserCheckHistory < ApplicationRecord
  belongs_to :user_history
  belongs_to :user_check
end
