class Bank < ActiveRecord::Base
	has_many :accounts
	validates :name, :comissions_amount_earned
end
