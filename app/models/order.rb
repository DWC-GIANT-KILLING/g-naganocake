class Order < ApplicationRecord
  enum payment: { credit_card: 0, transfer: 1 }
  enum status: { waiting: 0, confirmation: 1, production: 2, packing: 3, sent: 4 }
  has_many :order_details
  belongs_to :customer
  validates :postcode,  presence: true, numericality: {only_integer: true}, length: { is: 7 }
  
  def subtotal
    item.with_tax_price * piece
  end
end
