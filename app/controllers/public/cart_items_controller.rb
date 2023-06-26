class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!
  
  def index
    @customer = current_customer
    @price = 0
  end
  
  def update
    @in_cart = CartItem.find(params[:id])
    if @in_cart.update(cart_item_params)
      flash[:notice] = "変更を保存しました"
      redirect_to cart_items_path(current_customer.id)
    else
      flash[:notice] = "変更を保存できませんでした"
      render cart_items_path(current_customer_id)
    end
  end
  
  def destroy
    CartItem.find(params[:id]).destroy
    flash[:notice] = "商品を削除しました"
    redirect_to cart_items_path(current_customer)
  end
  
  def destroy_all
    current_customer.cart_items.destroy_all
    flash[:notice] = "全ての商品を削除しました"
    redirect_to cart_items_path(current_customer)
  end
  
  def create
      @cart_item = CartItem.new(cart_item_params)
      @customer = current_customer
      @item = @cart_item.item_id 
    if CartItem.find_by(item_id: @item)
      @in_cart = CartItem.find_by(item_id: @item)
      new_piece = @in_cart.piece.to_i + @cart_item.piece.to_i
      if@in_cart.update(piece: new_piece)
        flash[:notice] = "既存の商品に追加しました"
        redirect_to cart_items_path(current_customer.id)
      else
        flash[:notice] ="商品の追加に失敗しました"
        render 'public/items/show'
      end
    else
      @cart_item.customer_id = current_customer.id
      if @cart_item.save
        flash[:notice] = "商品を追加しました"
        redirect_to cart_items_path(@customer)
      else
        flash[:notice] ="商品の追加に失敗しました"
        @item = Item.find(params[:cart_item][:item_id])
        render 'public/items/show'
      end
    end
  end
  
  
  private
  
  def cart_item_params
    params.require(:cart_item).permit(:id, :item_id, :piece)
  end

end