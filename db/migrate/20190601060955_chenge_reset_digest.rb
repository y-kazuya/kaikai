class ChengeResetDigest < ActiveRecord::Migration[5.1]
  def change
    rename_column :accounts, :reset_password_token, :reset_digest
    rename_column :accounts, :reset_password_sent_at, :reset_sent_at

  end
end
