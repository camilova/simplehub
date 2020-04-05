class AdministrationController < ApplicationController

  def index
    @items = Item.all
    @item = Item.find(params[:item].presence || Item.first.id)
    @orders = @item.orders
    @order = Order.find(params[:order].presence || @item.orders.first.id)
    @sources = @order.sources
  end

end
