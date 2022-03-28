# == Schema Information
#
# Table name: videos
#
#  id             :bigint           not null, primary key
#  description    :string
#  meta_data      :jsonb
#  platform       :integer          default("youtube")
#  status         :integer          default("processing")
#  thumbnail      :string
#  title          :string
#  total_dislikes :integer          default(0)
#  total_likes    :integer          default(0)
#  total_view     :integer          default(0)
#  video_url      :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  upload_user_id :integer
#
# Indexes
#
#  index_videos_on_meta_data       (meta_data) USING gin
#  index_videos_on_upload_user_id  (upload_user_id)
#
FactoryBot.define do
  factory :video do
    title { 'ABC' }
    description { 'description' }
    platform { :youtube }
    video_url { 'https://www.youtube.com/watch?v=m-PJmmvyP10&list=RDdMtMx_dYk-w&index=7' }
    status { :completed }
  end
end
