class CreateUserVideo < ActiveRecord::Migration[7.0]
  def change
    create_table :user_videos do |t|
      t.integer :user_id
      t.integer :video_id
      t.integer :status

      t.timestamps
    end

    add_index :user_videos, :user_id
    add_index :user_videos, :video_id
    add_index :user_videos, :status
  end
end
