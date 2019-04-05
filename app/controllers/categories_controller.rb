class CategoriesController < ApplicationController

  before_action :find_category, only: [:show, :update, :edit, :destroy]

  def index
    @categories = Category.all
  end

  def show
     @category = Category.find(params[:id])
     @books = @category.bookofcategory
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:info] = "Adding Category Success!"
      redirect_to @category
    else    
      render 'new'
    end
  end

  def edit; end

  def update
    if @category.update_attributes(category_params)
      flash[:success] = "Category updated"
      redirect_to @category
    else
      render 'edit'
    end
  end

  def destroy
    @category.destroy
    flash[:success] = "Category deleted"
    redirect_to categories_url
  end

  private 

    def find_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:name)
    end
end
