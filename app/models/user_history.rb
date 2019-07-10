class UserHistory < ApplicationRecord
  belongs_to :user
  has_many :user_check_histories, dependent: :destroy
  accepts_nested_attributes_for :user_check_histories

  after_create :make_check_history  ##batchではコールバックかからないため、bacthとの２重処理にならない







  def make_check_history
    user_check_histories = []
    self.user.checks.each do |check|
      user_check_id = UserCheck.find_by(user_id: self.user, check_id: check.id).id
      user_check_histories << UserCheckHistory.new(user_history_id: self.id, user_check_id: user_check_id ,check_id: check.id)
    end
    UserCheckHistory.import user_check_histories

  end

end
