class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.integer :genre_id
      t.string :name
      t.integer :unit_price
      t.text :detail
      t.boolean :is_selling, default: false
      t.timestamps
    end
  end
end