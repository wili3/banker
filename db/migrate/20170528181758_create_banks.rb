class CreateBanks < ActiveRecord::Migration
  def change
    create_table :banks do |t|
      t.string :name
      t.float :comissions_amount_earned

      t.timestamps null: false
    end
  end
end
