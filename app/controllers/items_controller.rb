class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :set_main_item, only: [:new]
  before_action :set_category, only: [:new, :index]

  # GET /items
  # GET /items.json
  def index
    @categories = Category.all
    @category ||= Category.default.name
    if @category == Category.default
      @items = Item.main.all
    else
      @items = Item.main.joins(:item_categories).where(item_categories: { category_id: [@category] })
    end
  end

  # GET /items/1
  # GET /items/1.json
  def show
  end

  # GET /items/new
  def new
    @item = Item.new
    @item.item = @main_item
    @item.categories << @category unless @category.nil? || @category == Category.default
    render partial: 'form', callback: 'modal', 
      locals: { item: @item }
  end

  # GET /items/1/edit
  def edit
    render partial: 'form', callback: 'modal', 
      locals: { item: @item }
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(item_params)
    @item.published_at = Date.today
    if @item.save
      object_name = (@item.main?? 'item' : 'subitem')
      render partial: object_name, callback: "prepend#{object_name.capitalize}",
        locals: { "#{object_name}": @item }
    else
      head :internal_server_error
    end
  end

  # PATCH/PUT /items/1
  def update
    if @item.update(item_params)
      object_name = (@item.main?? 'item' : 'subitem')
      render partial: object_name, callback: 'replace',
        locals: { "#{object_name}": @item }
    else
      head :internal_server_error
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    
    def set_item
      @item = Item.find(params[:id])
    end

    def set_main_item
      @main_item = Item.find(params[:item]) if params[:item].present?
    end

    def set_category
      @category = Category.find_by_name(params[:category])
    end

    def item_params
      params.require(:item).permit(:title, :description, :deprecated, :item_id, category_ids: [])
    end
end
