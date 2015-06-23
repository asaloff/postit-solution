class CategoriesController < ApplicationController
  before_action :require_user, except: [:show]

  def show
    @category = Category.find(params[:id])
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(params.require(:category).permit(:name))

    if @category.save
      flash["notice"] = "Category Created Successfully"
      redirect_to category_path(@category)
    else
      render 'new'
    end
  end
end