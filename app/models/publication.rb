class Publication < ActiveRecord::Base
  attr_accessible :content, :title, :year
	belongs_to :user
	
	validates :year, presence: true, length: { maximum: 4 }
	validates :title, presence: true, length: { maximum: 50 }
	validates :content, presence: true, length: { maximum: 1000 }
	validates :user_id, presence: true
	default_scope order: 'publications.created_at DESC'
  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", 
          user_id: user.id)
  end
end
