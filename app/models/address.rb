class Address < ApplicationRecord
  before_action :authenticate_customer!
  
  belongs_to :customer
  
  def address_display
  '〒' + postcode + ' ' + address + ' ' +full_name
  end

end
