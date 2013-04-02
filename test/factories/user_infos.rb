# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_info do
    surname
    name
    mail
  end
end