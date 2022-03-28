class CreateComment < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.integer :video_id
      t.integer :user_id
      t.string :comment
      t.integer :reference_comment_id

      t.timestamps
    end

    add_index :comments, :video_id
    add_index :comments, :user_id
    add_index :comments, :reference_comment_id
  end
end
