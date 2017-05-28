class AddBankIdToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :bank_id, :integer
  end
end
