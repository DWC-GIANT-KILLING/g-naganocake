class Public::ItemsController < ApplicationController
  def index
    @items = Item.page(params[:page])
  end

  def show
    @item = Item.find(params[:id])
  end

  private

  def item_params
    params.require(:item).permit(:id, :genre_id, :name, :unit_price, :detail, :is_selling, :image)
  end
end
