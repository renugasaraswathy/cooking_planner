class CreatePrerequisitesSteps < ActiveRecord::Migration
  def change
    create_table :prerequisites_steps do |t|
      t.integer :recipe_id
      t.text :description
      t.integer :step_no

      t.timestamps
    end
  end
end
