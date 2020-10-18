class CreateWalletTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :wallet_transactions do |t|
      t.decimal :amount, precision: 12, scale: 2, null: false, default: 0
      t.decimal :transact_from_initial, precision: 12, scale: 2
      t.decimal :transact_from_final, precision: 12, scale: 2
      t.decimal :transact_to_initial, precision: 12, scale: 2
      t.decimal :transact_to_final, precision: 12, scale: 2
      t.references :transact_from, polymorphic: true, null: false, index: {name: 'index_wallet_transactions_on_transact_from'}
      t.references :transact_to, polymorphic: true, null: false, index: {name: 'index_wallet_transactions_on_transact_to'}
      t.string :type, null: false

      t.timestamps
    end
  end
end
