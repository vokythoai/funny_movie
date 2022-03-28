# frozen_string_literal: true

# == Schema Information
#
# Table name: comments
#
#  id                   :bigint           not null, primary key
#  comment              :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  reference_comment_id :integer
#  user_id              :integer
#  video_id             :integer
#
# Indexes
#
#  index_comments_on_reference_comment_id  (reference_comment_id)
#  index_comments_on_user_id               (user_id)
#  index_comments_on_video_id              (video_id)
#
class Comment < ActiveRecord::Base
  belongs_to :video
  belongs_to :user
  belongs_to :reference_comment, foreign_key: :reference_comment_id, class_name: 'Comment'
end
