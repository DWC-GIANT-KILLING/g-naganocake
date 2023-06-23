class Item < ApplicationRecord
  belongs_to :genre
  has_many :order_details
  has_many :cart_items
   has_one_attached :image
  def with_tax_price
    (price * 1.1).floor
  end

  #商品画像
  #def get_item_image
    #unless item_image.attached?
      #file_path = Rails.root.join('app/assets/images/no_image.jpg')
      #item_image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpeg')
    #end
    #item_image.variant(resize_to_limit: [100, 200]).processed
  #end
end

