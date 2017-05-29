require 'rails_helper'

RSpec.describe TransactionAgent, type: :service do
  context "When transaction succeed between same bank accounts" do
    let(:transaction) { Transaction.new(sender_id:1, receiver_id:2, money:1000, status:"Succeed") }
    let(:creator) { TransactionAgent.new(transaction, true) }

    it "removes money from sender" do
      expect{creator.send_money}.to change{Account.where(id: transaction.sender_id).first.reload.money}.by(-transaction.money)
    end

    it "gives money to the receiver" do
      expect{creator.send_money}.to change{Account.where(id: transaction.receiver_id).first.reload.money}.by(transaction.money)
    end
  end

  context "When transaction succeed between same bank accounts" do
    let(:transaction) { Transaction.new(sender_id:1, receiver_id:2, money:1000, status:"Failed") }
    let(:creator) { TransactionAgent.new(transaction, true) }

    it " doesn't removes money from sender" do
      expect{creator.send_money}.to_not change{Account.where(id: transaction.sender_id).first.reload.money}
    end

    it "doesn't gives money to the receiver" do
      expect{creator.send_money}.to_not change{Account.where(id: transaction.receiver_id).first.reload.money}
    end
  end

  context "When transaction succeed between different bank accounts" do
    let(:sender_id) { Bank.first.accounts.first.id }
    let(:receiver_id) { Bank.last.accounts.first.id }
    let(:transaction) { Transaction.new(sender_id:sender_id, receiver_id:receiver_id, money:1000, status:"Succeed") }
    let(:creator) { TransactionAgent.new(transaction, false) }

    it "removes money from sender and comissions" do
      expect{creator.send_money}.to change{Account.where(id: transaction.sender_id).first.reload.money}.by(-transaction.money - 5)
    end

    it "gives money to the receiver" do
      expect{creator.send_money}.to change{Account.where(id: transaction.receiver_id).first.reload.money}.by(transaction.money)
    end

    it "gives comissions to the bank" do
      expect{creator.send_money}.to change{Account.where(id: transaction.sender_id).first.bank.reload.comissions_amount_earned}.by(5)
    end
  end

  context "When transaction succeed between different bank accounts" do
    let(:sender_id) { Bank.first.accounts.first.id }
    let(:receiver_id) { Bank.last.accounts.first.id }
    let(:transaction) { Transaction.new(sender_id:sender_id, receiver_id:receiver_id, money:3000, status:"Failed") }
    let(:creator) { TransactionAgent.new(transaction, false) }

    it "doesn't removes money from sender and comissions" do
      expect{creator.send_money}.to_not change{Account.where(id: transaction.sender_id).first.reload.money}
    end

    it "doesn't gives money to the receiver" do
      expect{creator.send_money}.to_not change{Account.where(id: transaction.receiver_id).first.reload.money}
    end

    it "doesn't gives comissions to the bank" do
      expect{creator.send_money}.to_not change{Account.where(id: transaction.sender_id).first.bank.reload.comissions_amount_earned}
    end
  end
end