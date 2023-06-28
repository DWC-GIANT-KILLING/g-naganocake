class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!

  def update
    @order_detail = OrderDetail.find(params[:id])
    @order = @order_detail.order
    @order_detail.update(order_detail_params)
    if @order_detail.status == "in_progress"
      @order.update(status: "production")
    end

    if @order_detail.status == "completed"
      # やりたいこと: すべての商品の製作が完了しているか確認する

      if @order.order_details.count == @order.order_details.where(status: 'completed').count
        @order.update(status: "packing")
      end
    end

    redirect_to admin_order_path( @order_detail.order)
  end

  private

  def order_detail_params
    params.require(:order_detail).permit( :order_id, :item_id, :piece, :price, :status)
  end

end
