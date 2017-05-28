require 'rails_helper'

RSpec.describe TransactionAgent, type: :service do
  context "When transaction succeed between same bank accounts" do
    let(:transaction) { Transaction.new(sender_id:1, receiver_id:2, money:1000, status:"Succeed") }
    let(:creator) { TransactionAgent.new(transaction, true) }

    it "removes money from sender" do
      account = Account.where(id: transaction.sender_id).first
      expect{creator.send_money}.to change(account, :money).by(-transaction.money)
    end

    it "gives money to the receiver" do
      expect{creator.send_money}.to change(Account.where(id: transaction.receiver_id).first, :money).by(transaction.money)
    end
  end
end