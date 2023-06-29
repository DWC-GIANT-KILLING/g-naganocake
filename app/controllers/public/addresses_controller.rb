class Public::AddressesController < ApplicationController
  before_action :authenticate_customer!
  
  def index
    @address = Address.new
    @customer = current_customer
  end

  def edit
    @address = Address.find(params[:id])
  end

  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    if @address.save
       flash[:notice] = "新しい配送先を登録しました"
       redirect_to addresses_path
    else
       @addresses = current_customer.addresses
       render :index
    end
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
       flash[:notice] = "登録情報を更新しました"
       redirect_to addresses_path
    else
        render :edit
    end
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    flash[:notice] = "登録先を1件削除しました"
    redirect_to addresses_path
  end



  private

  def address_params
    params.require(:address).permit(:postcode, :address, :full_name)
  end

end
