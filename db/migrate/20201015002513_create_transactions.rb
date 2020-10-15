class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.decimal :amount, precision: 12, scale: 2, null: false, default: 0
      t.references :transact_from, polymophic: true, null: false
      t.references :transact_to, polymorphic: true, null: false
      t.string :type, null: false

      t.timestamps
    end
  end
end
