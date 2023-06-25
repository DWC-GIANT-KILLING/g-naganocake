class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def create
    @order = current_customer.order.new(order_params)
    @order.save
    @cart_items = current_customer.cart_items
    
    @cart_items.each do |cart_item|
      @order_details = OrderDetail.new
      @order_details.order_id = @order.id
      @order_details.item_id = cart_item.item.id
      @order_details.count = cart_item.count
      @order_details.tax_in_price = cart_item.item.with_tax_price
      @order_details.save
    end
    redirect_to orders_checked_path 
    current_customer.cart_items.destory_all
  end

  def check
    @order = Order.new(order_params)
    @cart_items = current_customer.cart_items
    @postage = 400
    
    #自身の住所
    if params [:order][:select_address] =="0"
      @order.postcode = current_customer.postcode
      @order.address = current_customer.address
      @order.full_name = current_customer.first_name + current_customer.last_name
    
    #登録済住所から選択
    elsif params[:order][:select_address] =="1"
      @address = Address.find(params[:order][:addresses_id])
      @order.postcode = current_customer.postcode
      @order.address = current_customer.address
      @order.full_name = current_customer.first_name + current_customer.last_name
  
    #新しいお届け先
    elsif params[:order][:select_address] =="2"
      @order.postcode = [:order][:postcode]
      @order.address = [:ordre][:address]
      @order.full_name = [:order][:full_name]
    end
  end

  
  def thanx
  end

  def index
    @order = Order.find(params[:id])
    @orders = current_cutomer.orders
  end

  def show
    @order = Order.find(params[:id])
    @postage 400
  end
  
  
  
  private

  def order_params
    params.require(:order).permit(:payment_method, :postcode, :address, :full_name)
  end
  
end
