class CreateOrderDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :order_details do |t|
      t.integer :order_id
      t.integer :item_id
      t.integer :piece
      t.integer :price
      t.integer :status, default: 0
      t.timestamps
    end
  end
end
