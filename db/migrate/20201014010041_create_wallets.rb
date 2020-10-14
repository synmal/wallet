class CreateWallets < ActiveRecord::Migration[6.0]
  def change
    create_table :wallets do |t|
      t.decimal :balance, precision: 12, scale: 2, null: false, default: 0
      t.references :owner, polymorphic: true, null: false

      t.timestamps
    end

    add_index :wallets, [:owner_id, :owner_type], unique: true
  end
end
