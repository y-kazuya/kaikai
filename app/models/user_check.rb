class UserCheck < ApplicationRecord
  belongs_to :check
  belongs_to :user

  has_many :user_check_histories, dependent: :nullify

  after_save :make_check_history

  def make_check_history
    user = self.user
    if user.has_today_date?
      check_hisroty = UserCheckHistory.find_or_create_by(user_history_id: user.today_date.id, check_id: self.check_id)
      return if check_hisroty.user_check_id
      check_hisroty.update_attributes(user_check_id: self.id)
    end
  end

  # def set_check_histroy
  #   user = self.user
  #   if user.has_today_date?
  #     check_hisroty = UserCheckHistory.find_by( check_id: self.check_id,user_history_id: user.today_date.id)
  #     check_hisroty.update_attributes(user_check_id: self.id) if check_hisroty
  #   end

  # end

end
