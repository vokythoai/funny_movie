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
FactoryBot.define do
  factory :user_subscribe do
  end
end
