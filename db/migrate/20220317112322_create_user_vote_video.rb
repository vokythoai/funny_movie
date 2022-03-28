class CreateUserVoteVideo < ActiveRecord::Migration[7.0]
  def change
    create_table :user_vote_videos do |t|
      t.integer :video_id
      t.integer :user_id
      t.integer :direction, default: 0

      t.timestamps
    end

    add_index :user_vote_videos, :video_id
    add_index :user_vote_videos, :user_id
    add_index :user_vote_videos, :direction
  end
end
