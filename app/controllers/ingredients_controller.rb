class IngredientsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_no_response_found

  def index
    if params[:recipe_id]
      recipe = Recipe.find(params[:recipe_id])
      ingredients = recipe.ingredients
    else
      ingredients = Ingredient.all
    end
    render json: ingredients, include: :recipe
  end

  def show
    ingredient = Ingredient.find(params[:id])
    render json: ingredient
  end

  def create
    ingredient = Ingredient.create(ingredient_params)
    render json: ingredient, status: :created
  end

private

  def render_no_response_found
    render json: { errors: "No ingredients found" }, status: :not_found
  end

  def ingredient_params
    params.permit(:name, :quantity, :recipe_id)
  end
end
