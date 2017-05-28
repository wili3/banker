require 'rails_helper'

RSpec.describe Bank, type: :model do
   it "creates a bank with valid params" do
  	expect{
  		Bank.new(:name => "BBVA#{Bank.count}", :comissions_amount_earned => 0).save
  		}.to change(Bank, :count).by(1)
  end

  it "does not create a bank with invalid params" do
	expect{
  		Bank.new(:name => "BBVA#{Bank.count}").save
  		}.to_not change(Bank, :count)
  end
end
