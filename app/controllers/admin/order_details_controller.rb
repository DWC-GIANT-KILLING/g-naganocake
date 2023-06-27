class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!

  def update
   @order_details = Oreder_details.find(params[:id])
  end

  private

  def order_detail_params
    params.require(:order_detail).permit( :order_id, :item_id, :piece, :price, :status)
  end

end
