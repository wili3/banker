require 'rails_helper'

RSpec.describe Transaction, type: :model do
  it "creates a Transaction with valid params" do
  	expect{
  		Transaction.new(:sender_id => 1, :receiver_id => 1, :money => 200, :status => "Failed").save
  		}.to change(Transaction, :count).by(1)
  end

  it "does not create a Transaction with invalid params" do
	expect{
  		Transaction.new(:sender_id => 2).save
  		}.to_not change(Transaction, :count)
  end
end
