require 'rails_helper'

RSpec.describe Account, type: :model do
  it "does not create an account with invalid params" do
  	expect{
  		Account.new(:holder_name => "Jodie", :bank_id => 2).save
  		}.to_not change(Account, :count)
  end

  it "does not create an account with invalid params" do
	expect{
  		Account.new(:holder_name => "Jodie", :money => 60000, :bank_id => 2).save
  		}.to change(Account, :count).by(1)
  end
end
