namespace :set_up_system do
  desc "TODO"
  
task init_categories: :environment do 
	Category.create(:name=>'Tiffin')	
	Category.create(:name=>'Cake')		
	Category.create(:name=>'Soup')	
	Category.create(:name=>'Roti')
	Category.create(:name=>'Gravy')
	Category.create(:name=>'Ice creams')
	Category.create(:name=>'Juice')
	Category.create(:name=>'Milk Shake')
	Category.create(:name=>'Snacks')
	Category.create(:name=>'Starters')
	Category.create(:name=>'Salads')
	puts "Default categories created"
end

task init_ingredients: :environment do
	file=Rails.root.join('lib','default_data','ingredients.txt')
	File.foreach(file) do |f|  		
  		Ingredient.create(:name=>f.gsub(/\n/, ""))
  	end
  	puts "Default Ingredients created"
end


	task :start => [:environment, 'db:create', 'db:migrate','init_categories','init_ingredients']
end
