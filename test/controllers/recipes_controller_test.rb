require 'test_helper'

class RecipesControllerTest < ActionController::TestCase
  setup do
    @recipe = recipes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:recipes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create recipe" do
    assert_difference('Recipe.count') do
      post :create, recipe: { diet_type: @recipe.diet_type, has_prerequisites: @recipe.has_prerequisites, name: @recipe.name, no_of_persons: @recipe.no_of_persons, published: @recipe.published, recipe_type: @recipe.recipe_type, time_required: @recipe.time_required, user_id: @recipe.user_id }
    end

    assert_redirected_to recipe_path(assigns(:recipe))
  end

  test "should show recipe" do
    get :show, id: @recipe
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @recipe
    assert_response :success
  end

  test "should update recipe" do
    patch :update, id: @recipe, recipe: { diet_type: @recipe.diet_type, has_prerequisites: @recipe.has_prerequisites, name: @recipe.name, no_of_persons: @recipe.no_of_persons, published: @recipe.published, recipe_type: @recipe.recipe_type, time_required: @recipe.time_required, user_id: @recipe.user_id }
    assert_redirected_to recipe_path(assigns(:recipe))
  end

  test "should destroy recipe" do
    assert_difference('Recipe.count', -1) do
      delete :destroy, id: @recipe
    end

    assert_redirected_to recipes_path
  end
end
