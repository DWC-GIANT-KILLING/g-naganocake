class Public::CartItemsController < ApplicationController
  def index
    @customer = current_customer
    #@price = 
  end
  
  def update
    @cart_item = Cart_item.find(params[:id])
    if @cart_item.update(cart_item_params)
      flash[:notice] = "変更を保存しました"
      redirect_to cart_items_path(current_customer_id)
    else
      flash[:notice] = "変更を保存できませんでした"
      render cart_items_path(current_customer_id)
    end
  end
  
  def destroy
    Cart_item.find(params[:id]).destroy
    flash[:notice] = "商品を削除しました"
    redirect_to cart_items_path(params[:current_customer_id])
  end
  
  def destroy_all
    current_customer.cart_item.destroy_all
    flash[:notice] = "全ての商品を削除しました"
    redirect_to cart_items_path(params[:current_customer_id])
  end
  
  def create
    @customer = current_customer
    @item = Item.find
    if @customer.cart_item.fid_by(item_id: @item)
      @cart_item = Cart_item.new(cart_params)
       in_cart = @customer.cart_item.fid(item_id: @item)
       @cart_item.piece = in_cart.piece.to_i + @cart_item.piece.to_i
       if@cart_item.update(cart_item_params)
         flash[:notice] = "既存の商品に追加しました"
         redirect to cart_items_path(current_customer_id)
       else
         flash[:notice] ="商品の追加に失敗しました"
         render item_path(@item)
       end
    else
      @cart_item = Cart_item.new(cart_params)
      @cart_item.customer_id = current_customer.id
      if @cart_item.save
        flash[:notice] = "商品を追加しました"
        redirect to cart_items_path(current_customer_id)
      else
        flash[:notice] ="商品の追加に失敗しました"
        render item_path(@item)
      end
    end
  end
  
  
  private
  
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :piece)
  end

end