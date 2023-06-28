class OrderDetail < ApplicationRecord
  enum status: {not_started: 0,pending: 1,in_progress: 2,completed: 3}
  belongs_to :item
  belongs_to :order

  def with_tax_price
    (unit_price * 1.1).floor
  end

  def subtotal
    item.with_tax_price * piece
  end

end
