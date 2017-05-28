class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :holder_name
      t.float :money

      t.timestamps null: false
    end
  end
end
