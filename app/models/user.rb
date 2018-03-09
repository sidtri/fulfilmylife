# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  email              :string           not null
#  encrypted_password :string(128)      not null
#  confirmation_token :string(128)
#  remember_token     :string(128)      not null
#

class User < ApplicationRecord
  include Clearance::User

  has_many :stats
  has_and_belongs_to_many :programs
  has_many :cards, through: :programs

  def self.from_omniauth(auth)
	where(email: auth["info"]["email"]).first_or_initialize.tap do |user|
	  user.email = auth["info"]["email"]
	  # user.password = ENV["default_password"]
	  # user.password_confirm = ENV["default_password"]
	  user.provider = auth.provider
	  user.uid = auth.uid
	  user.name = auth.info.name
	  user.oauth_token = auth.credentials.token
	  user.oauth_expires_at = Time.at(auth.credentials.expires_at)
	  user.save!
	end
  end
end
