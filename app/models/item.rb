class Item < ApplicationRecord
  belongs_to :genre
  has_many :order_details
  has_many :cart_items
   has_one_attached :image
  def with_tax_price
    (price * 1.1).floor
  end

  #商品画像
  def get_item_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpeg')
    end
     image.variant(resize_to_limit: [width, height]).processed
  end
end

