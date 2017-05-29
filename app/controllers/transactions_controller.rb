class TransactionsController < ApplicationController
  #creates a transaction with the given params, if some params are missing, the transaction will be nil, if not it will render a json with the transaction data
  def create
  	@transaction = TransactionCreator.new(params).create

  	if @transaction
  		render :index
  	else
  		render json: {error: "parameters missing"}, status: 400
  	end
  end
end
