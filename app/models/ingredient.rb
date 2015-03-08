class Ingredient < ActiveRecord::Base
	validates :name,:presence=>true
	validates :name,:uniqueness=>true
	extend FriendlyId
  	friendly_id :name, use: :slugged
  	before_save :convert_name_to_lowercase
  	has_many :recipe_ingredients,:foreign_key=>'ingredients_id'
  	def convert_name_to_lowercase
  		self.name=self.name.downcase
  	end
end
