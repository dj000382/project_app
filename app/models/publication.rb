class Publication < ActiveRecord::Base
  attr_accessible :content, :title, :year
	belongs_to :user
	
	validates :year, presence: true, length: { maximum: 4 }
	validates :title, presence: true, length: { maximum: 50 }
	validates :content, presence: true, length: { maximum: 1000 }
	validates :user_id, presence: true
	default_scope order: 'publications.created_at DESC'
end
