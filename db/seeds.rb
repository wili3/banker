# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Bank.create(
	name: 'SHINRA',
	comissions_amount_earned: 0,
)

Bank.create(
	name: 'REDRIBBON',
	comissions_amount_earned: 0,
)

2.times do
	Account.create(
		holder_name: Faker::Name.first_name,
		money: 50000,
		bank_id: 1,
	)
end

2.times do
	Account.create(
		holder_name: Faker::Name.first_name,
		money: 50000,
		bank_id: 2,
	)
end

Account.create(
		holder_name: 'Jim',
		money: 50000,
		bank_id: 1,
)

Account.create(
		holder_name: 'Emma',
		money: 50000,
		bank_id: 2,
)