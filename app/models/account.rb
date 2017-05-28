class Account < ActiveRecord::Base
	belongs_to :bank
	validates :holder_name, :money, :bank_id, presence: true
end
