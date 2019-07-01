class History < ApplicationRecord
  belongs_to :user
  has_many :check_histories, dependent: :destroy
end
