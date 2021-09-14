class RecipesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_no_response_found

  def show
    recipe = Recipe.find_by(id: params[:id])
    render json: recipe, include: :ingredients
  end

private

  def render_no_response_found
    render json: { errors: "No recipes found" }, status: :not_found
  end
end
