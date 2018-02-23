# == Schema Information
#
# Table name: programs
#
#  id         :integer          not null, primary key
#  name       :string
#  period     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Program < ApplicationRecord
  has_many :cards
  has_many :pushups, -> { pushups }, class_name: "Card"

  has_many :habits, -> { habits }, class_name: "Card"

  has_many :card_templates
  has_many :event, through: :card_templates

  # has_one :pushup, -> { pushups.first(:order => "RANDOM()") }

  has_and_belongs_to_many :users
end
