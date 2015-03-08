class CreateFamilyMembers < ActiveRecord::Migration
  def change
    create_table :family_members do |t|
      t.references :family, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
