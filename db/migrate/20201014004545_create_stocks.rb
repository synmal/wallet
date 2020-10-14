class CreateStocks < ActiveRecord::Migration[6.0]
  def change
    create_table :stocks do |t|
      t.string :name, null: false

      t.timestamps
    end

    add_index :stocks, :name, unique: true
  end
end
