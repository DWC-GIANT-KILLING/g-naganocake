class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!

  def update
   @order_details = OrderDetail.find(params[:id])
   @order_details.update(order_detail_params)
   redirect_to admin_order_path( @order_details.order)
  end

  private

  def order_detail_params
    params.require(:order_detail).permit( :order_id, :item_id, :piece, :price, :status)
  end

end
