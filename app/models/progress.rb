# == Schema Information
#
# Table name: progresses
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  card_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Progress < ApplicationRecord
  belongs_to :user
  belongs_to :card
end
