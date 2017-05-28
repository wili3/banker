require 'rails_helper'

RSpec.describe TransactionsController, type: :controller do

  describe "GET #create" do
    it "creates a new transaction with valid params" do
      expect{
        post :create,  :sender_id => 1, :receiver_id => 2, :money => 1000
      }.to change(Transaction,:count).by(1)
    end

    it "doesn't creates a new transaction with invalid params" do
      expect{
        post :create,	 :receiver_id => 2, :money => 1000
      }.to_not change(Transaction,:count)
    end
  end

end
