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
  attr_accessible :labo, :nom, :prenom ,  :password, :password_confirmation , :email
	has_secure_password
	has_many :publications , dependent: :destroy

	before_save { |user| user.email = email.downcase }
	before_save :create_remember_token

	validates :nom, presence: true , length: { maximum: 50 }
	validates :prenom, presence: true , length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
	validates :labo, presence: true , length: { maximum: 50 }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

	def feed
    # This is preliminary. See "Following users" for the full implementation.
    Publication.where("user_id = ?", id)
  end
	private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
