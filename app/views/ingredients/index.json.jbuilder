json.array!(@ingredients) do |ingredient|
  json.extract! ingredient, :id, :name, :unit_name
  json.url ingredient_url(ingredient, format: :json)
end
