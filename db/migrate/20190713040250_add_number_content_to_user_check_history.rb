class AddNumberContentToUserCheckHistory < ActiveRecord::Migration[5.1]
  def change
    add_column :user_check_histories, :number_content, :string
  end
end
