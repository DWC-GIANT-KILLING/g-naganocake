class OrderDetail < ApplicationRecord
  enum status_method: {not_started: 0,pending: 1,in_progress: 2,completed: 3,}
  belongs_to :item
  belongs_to :cart_item
  belongs_to :order
end
