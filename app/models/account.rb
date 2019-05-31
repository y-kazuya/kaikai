class Account < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i


  attr_accessor :remember_token, :activation_token, :reset_token

  before_save   :downcase_email


  validates :name, presence: true,
                   uniqueness: { case_sensitive: false } ,
                   length: { maximum: 30 }

  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  has_secure_password

  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true


  def Account.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def Account.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = Account.new_token  #selfを使わないとただremember_tokenに代入してるだけ、
    update_attribute(:remember_digest, Account.digest(remember_token))  #セキュアな情報はhash化してから返す日東洋がある
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  # def create_reset_digest
  #   self.reset_token = Account.new_token
  #   update_columns(reset_digest:  Account.digest(reset_token), reset_sent_at: Time.zone.now)
  # end

  # def send_password_reset_email
  #   UserMailer.password_reset(self).deliver_now
  # end

  # def password_reset_expired?
  #   reset_sent_at < 2.hours.ago
  # end

  private

  def downcase_email
    self.email = email.downcase
  end



end
