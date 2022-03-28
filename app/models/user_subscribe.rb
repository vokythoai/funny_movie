# frozen_string_literal: true

# == Schema Information
#
# Table name: user_subscribes
#
#  id               :bigint           not null, primary key
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  subcribe_user_id :integer
#  user_id          :integer
#
# Indexes
#
#  index_user_subscribes_on_subcribe_user_id  (subcribe_user_id)
#  index_user_subscribes_on_user_id           (user_id)
#
class UserSubscribe < ActiveRecord::Base
  belongs_to :subcribe_user, foreign_key: :subcribe_user_id, class_name: 'User'
  belongs_to :user
end
