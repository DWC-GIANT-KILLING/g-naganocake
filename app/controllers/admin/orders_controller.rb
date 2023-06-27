class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      flash[:notice] = "更新しました！"
      redirect_to admin_order_path(@order)
    end
  end

  private

  def order_params
    params.require(:order).permit( :customer_id, :delivery_cost, :payment, :address, :postcode, :full_name, :total_price, :status)
  end

end
