class CheckHistory < ApplicationRecord
  belongs_to :user_check
  belongs_to :history
end
