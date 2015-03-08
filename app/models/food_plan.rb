class FoodPlan < ActiveRecord::Base
  belongs_to :user
  belongs_to :family
  belongs_to :recipe
end
