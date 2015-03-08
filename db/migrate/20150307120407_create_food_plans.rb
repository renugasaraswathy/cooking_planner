class CreateFoodPlans < ActiveRecord::Migration
  def change
    create_table :food_plans do |t|
      t.references :user, index: true
      t.references :family, index: true
      t.references :recipe,index: true
      t.date :day
      t.integer :food_type

      t.timestamps
    end
  end
end
