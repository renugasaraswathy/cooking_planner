class CreateFamilies < ActiveRecord::Migration
  def change
    create_table :families do |t|
      t.string :name
      t.string :access_code
      t.string :slug
      t.timestamps
    end
  end
end
