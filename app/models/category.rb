class Category < ActiveRecord::Base
	extend FriendlyId	
  	friendly_id :name, use: :slugged  	
	has_many :recipes
	belongs_to :user
	validates :name,:presence=>true
	before_save :validate_name
	
	def validate_name
    	self.errors.add(:name,"is blank") if self.name==""    
  	end

  	def public_recipes_count
  		self.recipes.public_recipes.count
  	end

    def user_private_recipes_count(user)
      self.recipes.where(:user_id=>user.family.users.collect(&:id),:recipe_type=>PRIVATE).count
    end

    def recipes_count(user)
      self.public_recipes_count+user_private_recipes_count(user)
    end

  	def self.popular_categories(user)
  	categories_count={}
  	Category.all.each do |cat|
  		categories_count[cat.id]=cat.recipes_count(user)
  	end
  	return Hash[categories_count.sort_by{ |_, v| -v }[0..4]]
  end

end
