class TransactionCreator
	attr_reader :sender_id, :receiver_id, :money

	def initialize(params)
		@sender_id = params[:sender_id]
		@receiver_id = params[:receiver_id]
		@money = params[:money]
		@transaction = Transaction.new
	end
	#creates a transaction if the parameters are not missing, the transaction can be created even if It fails in order to make sure that we can notice our account holders tht the transaction failed
	def create
		if missing_params
			if enough_money
				check_same_bank
			else
				create_failed_transaction
			end
		else
			nil
		end
	end

	private
	#checks if any crucial param is missing
	def missing_params
		@sender_id != nil && @receiver_id != nil && @money != nil
	end
	#check if the 2 accounts are from the same bank
	def check_same_bank
		if same_bank?
			create_successful_transaction
		else
			if check_limit
				create_successful_transaction
			else
				create_failed_transaction
			end
		end
	end
	#check if there is enough money to make the transfer, if are from different banks, the check has an additional amount of 5
	def enough_money
		if same_bank?
			money.to_f <=  Account.where(id: sender_id).first.money.to_f
		else
			money.to_f + 5 <=  Account.where(id: sender_id).first.money.to_f
		end
	end
	#check if the amount is permitted
	def check_limit
		money.to_f <= 1000
	end

	def same_bank?
		sender_bank == receiver_bank
	end
	#gets the sender bank
	def sender_bank
		Bank.where(id: Account.where(id: sender_id).first.bank_id).first
	end
	#gets the receiver bank
	def receiver_bank
		Bank.where(id: Account.where(id: receiver_id).first.bank_id).first
	end
	#creates a successful transaction and gives it to TransactionAgent in order to 
	def create_successful_transaction
		create_transaction
		@transaction.status = "Succeed"
		@transaction.save
		TransactionAgent.new(@transaction, same_bank?).send_money
		@transaction
	end
	#creates a failed transaction
	def create_failed_transaction
		create_transaction
		@transaction.status = "Failed"
		@transaction.save
		@transaction
	end
	#creates a transaction
	def create_transaction
		@transaction.sender_id = @sender_id
		@transaction.receiver_id = @receiver_id
		@transaction.money = @money
	end
end