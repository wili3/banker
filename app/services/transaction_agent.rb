class TransactionAgent
	def initialize(transaction, same_bank)
		@transaction = transaction
		@same_bank = same_bank
	end

	# send money is triggered at the end of the TransactionCreator in order to deliver the money	
	def send_money
		if @transaction.status == "Succeed"
			@money = @transaction.money
			remove_money
			give_money
			get_comission
		end
	end

	private
	#removes money from sender account
	def remove_money
		account = Account.where(id: @transaction.sender_id).first
		account.update_attribute(:money, account.money - @money)
	end
	#gives money to receiver account
	def give_money
		account = Account.where(id: @transaction.receiver_id).first
		account.update_attribute(:money, account.money + @money)
	end
	#gets comission and gives it to the account's bank
	def get_comission
		if !@same_bank
			Account.where(id: @transaction.sender_id).first.update_attribute(:money, Account.where(id: @transaction.sender_id).first.money - 5)
			Account.where(id: @transaction.sender_id).first.bank.update_attribute(:comissions_amount_earned, Account.where(id: @transaction.sender_id).first.bank.comissions_amount_earned + 5)
		end
	end
end