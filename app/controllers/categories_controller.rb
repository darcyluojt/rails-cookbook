class CategoriesController < ApplicationController
  before_action :find_category, only: [ :show, :destroy ]
  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(strong_params)
    if @category.save
      redirect_to root_path, notice: "your category was created successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @category.destroy
    redirect_to root_path, notice: "your category was deleted successfully"
  end

  def show
  end

  private
  def strong_params
    params.require(:category).permit(:name)
  end

  def find_category
    @category = Category.find(params[:id])
  end
end
