json.array!(@recipes) do |recipe|
  json.extract! recipe, :id, :name, :no_of_persons, :has_prerequisites, :recipe_type, :diet_type, :time_required, :user_id, :published
  json.url recipe_url(recipe, format: :json)
end
