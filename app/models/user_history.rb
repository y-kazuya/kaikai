class UserHistory < ApplicationRecord
  belongs_to :user
  has_many :user_check_histories, dependent: :destroy

  after_create :make_check_history







  def make_check_history
    user_check_histories = []
    self.user.checks.each do |check|
      user_check_histories << UserCheckHistory.new(user_history_id: self.id, user_check_id: check.id)
    end

    UserCheckHistory.import user_check_histories

  end

end
