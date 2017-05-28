class Transaction < ActiveRecord::Base
	validates :sender_id, :receiver_id, :money, :status
end
