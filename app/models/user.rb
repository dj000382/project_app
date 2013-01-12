# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  nom        :string(255)
#  prenom     :string(255)
#  labo       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  attr_accessible :labo, :nom, :prenom ,  :password, :password_confirmation
	has_secure_password

	validates :nom, presence: true , length: { maximum: 50 }
	validates :prenom, presence: true , length: { maximum: 50 }
	validates :labo, presence: true , length: { maximum: 50 }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
end
