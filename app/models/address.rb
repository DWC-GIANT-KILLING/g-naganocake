class Address < ApplicationRecord
  
  belongs_to :customer
  
  validates :address, presence: true
  validates :postcode, format: { with: /\A\d{3}[-]\d{4}\z|\A\d{3}[-]\d{2}\z|\A\d{3}\z|\A\d{5}\z|\A\d{7}\z/, message: 'は半角数字で入力してください。' }
  validates :full_name, presence: true
  
  def address_display
  '〒' + postcode + ' ' + address + ' ' +full_name
  end

end
