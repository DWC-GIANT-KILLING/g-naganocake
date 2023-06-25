class CartItem < ApplicationRecord
  has_many :order_details
  belongs_to :item
  belongs_to :customer
  def subtotal
    item.with_tax_price * piece
  end
end