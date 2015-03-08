class Recipe < ActiveRecord::Base
	validates :name,:description,:no_of_persons,:recipe_type,:presence=>true
	belongs_to :category
	extend FriendlyId	
  	friendly_id :name, use: :slugged
  	attr_accessor :category_slug,:picture,:hours,:minutes
  	has_many :prerequisites_steps
  	has_many :recipe_steps	
  	has_many :recipe_ingredients    
    has_many :food_plans
  	has_one :avatar,:as=>:node
    belongs_to :user
  	before_save :set_category_and_time
  	after_save :save_avatar

    scope :public_recipes, -> { where(:recipe_type=>PUBLIC) }
    scope :private_recipes, -> { where(:recipe_type=>PRIVATE) }

  	def set_category_and_time  		
	   	self.category=Category.find_by_slug(self.category_slug) if self.category_slug		
      self.time_required="#{self.hours}:#{self.minutes}"
  	end

    def show_hours
      time_required=self.time_required
      time_required.split(":").first if time_required
    end

    def show_minutes
      time_required=self.time_required
      time_required.split(":").last if time_required
    end

    def short_description
      if self.description.length>250
        self.description[0..250]+"..."
      else
        self.description
      end
    end

    def save_avatar      
      if self.picture        
        avatar=self.avatar || Avatar.new(:node_type=>'Recipe',:node_id=>self.id)
        avatar.picture=self.picture
        avatar.save
      end
    end
end
