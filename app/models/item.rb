class Item <
  belongs_to :genres
  has_many :order_details, :cart_items
end
