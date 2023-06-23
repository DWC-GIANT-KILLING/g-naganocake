class Public::CustomersController < ApplicationController

  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      flash[:notice] = "会員情報が更新されました"
      redirect_to customers_mypage_path
    else
      render :edit
    end
  end

  def check
  end

  def withdraw
    customer = current_customer
    customer.is_deleted = false
    customer.save
    session.clear
    redirect_to root_path
  end

  protected

  def customer_params
    params.require(:customer).permit(:last_name,:first_name,:last_name_kana,:first_name_kana,
                          :postcode,:address,:phone_number,:email)
  end

end
