class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :customer_id
      t.integer :delivery_cost
      t.integer :payment
      t.string :address
      t.string :postcode
      t.string :full_name
      t.integer :total_price
      t.integer :status, default: 0
      t.timestamps
    end
  end
end
