class AddUserCodeToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :user_code, :string
  end
end
