class CardTemplate < ApplicationRecord
  belongs_to :card
  belongs_to :event
  belongs_to :program

  before_save do 
  	if self.name.blank? 
  		self.name = "#{self.card.try(:title)} - #{self.event.try(:name)}"
  	end
  end
end
