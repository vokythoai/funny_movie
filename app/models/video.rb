# frozen_string_literal: true

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
class Video < ActiveRecord::Base
  belongs_to :user, foreign_key: :upload_user_id
  has_many :user_videos
  has_many :user_vote_videos

  validates :video_url, :title, :description, :platform, presence: true
  validate :validate_video_url

  enum status: { processing: 0, completed: 1, failed: 2 }
  enum platform: { youtube: 0, tiktok: 1, mannual_upload: 2 }

  scope :active_video, -> { completed }

  delegate :email,
           to: :user,
           allow_nil: true,
           prefix: true

  def self.detect_platform(url)
    return :youtube if url =~ /youtube|youtu/
    return :tiktok if url =~ /tiktok/

    nil
  end

  def validate_video_url
    url_pattern = /^(http|https):\/\/www.[youtube|youtu|tiktok]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,6}(:[0-9]{1,5})?(\/.*)?$/
    return if video_url =~ url_pattern

    errors.add(:video_url, 'does not support')
  end

  def user_vote_info(user)
    user_vote_videos.find_by(user_id: user.id)
  end
end
