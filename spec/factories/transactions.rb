FactoryGirl.define do
  factory :transaction do
    sender_id 1
    receiver_id 1
    money 1
    status "MyString"
  end
end
