class Address < ApplicationRecord
  belongs_to :customer
  
  def address_display
  '〒' + postcode + ' ' + address + ' ' +full_name
  end

end
