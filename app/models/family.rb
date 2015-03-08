class Family < ActiveRecord::Base
	has_many :family_members
	has_many :users,:through=>:family_members
	has_many :food_plans
	validates :name,:access_code,:presence=>true
	validates :access_code,:uniqueness=>true
	extend FriendlyId	
	friendly_id :name, use: :slugged	
	  
	def add_family_members(user)
	 self.family_members.create(:user_id=>user.id)
	end
end
