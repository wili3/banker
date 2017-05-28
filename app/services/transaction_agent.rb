class TransactionAgent
	def initialize(transaction, same_bank)
		@transaction = transaction
		@same_bank = same_bank
	end

	def send_money
		@money = @transaction.money
		remove_money
		give_money
		get_comission
	end

	private

	def remove_money
		account = Account.where(id: @transaction.sender_id).first
		account.update_attribute(:money, account.money - @money)
	end

	def give_money
		account = Account.where(id: @transaction.receiver_id).first
		account.update_attribute(:money, account.money + @money)
	end

	def get_comission
		if !@same_bank
			Account.where(id: @transaction.sender_id).first.update_attribute(:money, Account.where(id: @transaction.sender_id).first.money - 5)
		end
	end
end