# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    login "admin"
    password "123"
    association :user_info
    association :company
    association :role
  end
end