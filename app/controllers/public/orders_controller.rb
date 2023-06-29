class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    @order = Order.new
  end

  def create
    @order = current_customer.orders.new(order_params)
    @order.save
    @cart_items = current_customer.cart_items

    @cart_items.each do |cart_item|
      @order_details = OrderDetail.new
      @order_details.order_id = @order.id
      @order_details.item_id = cart_item.item.id
      @order_details.piece = cart_item.piece
      @order_details.price = cart_item.item.with_tax_price
      @order_details.save
    end
    current_customer.cart_items.destroy_all
    redirect_to orders_thanx_path
  end

  def check
    @order = Order.new(order_params)
    @price = 0
    @cart_items = current_customer.cart_items

    #自身の住所
    if params[:order][:select_address] == "0"
      @order.postcode = current_customer.postcode
      @order.address = current_customer.address
      @order.full_name = current_customer.last_name + current_customer.first_name

    #登録済住所から選択
    elsif params[:order][:select_address] == "1"
      @address = Address.find(params[:order][:address_id])
      @order.postcode = @address.postcode
      @order.address = @address.address
      @order.full_name = @address.full_name

    #新しいお届け先
    elsif params[:order][:select_address] == "2"

    end
  end

  def thanx
  end

  def index
    @orders = current_customer.orders.page(params[:page])
  end

  def show
    @order = Order.find(params[:id])
    @price = 0
  end



  private

  def order_params
    params.require(:order).permit(:payment, :postcode, :address, :full_name, :total_price, :delivery_cost)
  end

end
