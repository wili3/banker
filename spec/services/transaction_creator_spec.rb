require 'rails_helper'

RSpec.describe TransactionCreator, type: :service do
  context "When some parameters are missing" do
    let(:params) { {sender_id:1, receiver_id:2} }
    let(:creator) { TransactionCreator.new(params) }

    it "returns nil" do
    	expect(creator.create).to be_nil
    end
  end

  context "When parameters are ok" do
    let(:params) { {sender_id:1, receiver_id:2, money:300} }
    let(:creator) { TransactionCreator.new(params) }

    it "creates a new transaction" do
    	expect{creator.create}.to change(Transaction, :count).by(1)
    end
  end
end
