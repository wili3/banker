class TransactionsController < ApplicationController
  def create
  	@transaction = TransactionCreator.new(params).create

  	if @transaction
  		render :index
  	else
  		render json: {error: "parameters missing"}, status: 422
  	end
  end
end
