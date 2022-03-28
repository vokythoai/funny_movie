class CreateVideo < ActiveRecord::Migration[7.0]
  def change
    create_table :videos do |t|
      t.string :title
      t.string :description
      t.string :thumbnail
      t.integer :upload_user_id
      t.integer :total_likes, default: 0
      t.integer :total_dislikes, default: 0
      t.integer :total_view, default: 0
      t.string :video_url
      t.integer :status, default: 0
      t.integer :platform, default: 0
      t.jsonb :meta_data, default: {}

      t.timestamps
    end

    add_index :videos, :upload_user_id
    add_index :videos, :meta_data, using: :gin
  end
end
