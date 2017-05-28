class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :sender_id
      t.integer :receiver_id
      t.integer :money
      t.string :status

      t.timestamps null: false
    end
  end
end
