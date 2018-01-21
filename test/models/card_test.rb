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

require 'test_helper'

class CardTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
