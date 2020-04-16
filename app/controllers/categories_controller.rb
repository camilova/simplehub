class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /categories/new
  def new
    @category = Category.new
    render partial: 'form', callback: 'modal'
  end

  # GET /categories/1/edit
  def edit
    render partial: 'form', callback: 'modal'
  end

  # POST /categories
  def create
    @category = Category.new(category_params)
    if @category.update(category_params)
      redirect_to root_path(category: @category.name)
    else
      head :internal_server_error
    end
  end

  # PATCH/PUT /categories/1
  def update
    if @category.update(category_params)
      redirect_to root_path(category: @category.name)
    else
      head :internal_server_error
    end
  end

  # DELETE /categories/1
  def destroy
    if @category.update(deleted: true)
      elements = ["category-#{@category.id}", "edit-category-#{@category.id}"]
      render json: elements.to_json, callback: 'destroy'
    else
      head :internal_server_error
    end
  end

  private

    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:name)
    end
end
