class BookmarksController < ApplicationController
  before_action :find_category, only: [ :new, :create ]
  def new
    @bookmark = Bookmark.new
  end

  def create
    @bookmark = Bookmark.new(strong_params)
    @bookmark.category = @category
    if @bookmark.save
      redirect_to @category, notice: "created!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    redirect_to category_path(@bookmark.category), status: :see_other
  end

  private
  def strong_params
    params.require(:bookmark).permit(:comment, :recipe_id)
  end

  def find_category
    @category = Category.find(params[:category_id])
  end
end
