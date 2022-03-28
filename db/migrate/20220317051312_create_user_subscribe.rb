class CreateUserSubscribe < ActiveRecord::Migration[7.0]
  def change
    create_table :user_subscribes do |t|
      t.integer :user_id
      t.integer :subcribe_user_id

      t.timestamps
    end

    add_index :user_subscribes, :user_id
    add_index :user_subscribes, :subcribe_user_id
  end
end
