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
  has_many :pushups, -> { cards.where(tag: "pushup") }

  has_and_belongs_to_many :users
end
