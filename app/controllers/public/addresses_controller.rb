class Public::AddressesController < ApplicationController
  def index
    @ = current_user
    @addresses = Address.all
  end

  def edit
    @address = Address.find(params[:id])
  end
  
  def create
    @address = Address.new(addresse_params)
    @address.save
    redirect_to addresse_path(@address.id)
  end
  
  def update
    @address = Address.find(params[:id])
    @address.update(address_params)
    redirect_to address_path(@address.id)
  end
  
  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    redirect_to address_path
  end
  
end
