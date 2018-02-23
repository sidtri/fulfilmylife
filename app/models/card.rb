# == Schema Information
#
# Table name: cards
#
#  id         :integer          not null, primary key
#  title      :string
#  sub_title  :string
#  total_time :string
#  content    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  tag        :integer
#  slug       :string
#  references :string
#

class Card < ApplicationRecord
	extend FriendlyId
	friendly_id :title, use: :slugged

	enum tag: [ :pushup, :habit, :survey ]

  belongs_to :program
  belongs_to :category
  has_many :events

  scope :pushups, -> { where(tag: "pushup") }
  scope :habits, -> { where(tag: "habit") }

  has_many :stats

	def to_param
		id.to_s
	end
end
