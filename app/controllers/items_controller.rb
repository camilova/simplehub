class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :set_main_item, only: [:new]
  before_action :set_category, only: [:new, :index]
  protect_from_forgery prepend: true
  before_action :authenticate_user!, except: [:index]
  before_action :set_admin_status

  # GET /items
  def index
    @categories = Category.all
    @category ||= Category.default
    if @category == Category.default
      @items = Item.main.all
    else
      @items = Item.main.joins(:item_categories).where(item_categories: { category_id: [@category.id] })
    end
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
  def destroy
    @item.update!(deleted: true)
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

    def set_admin_status
      @admin = user_signed_in?
    end
end
