# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :session_history do
    page "/standards"
    ip "127.0.0.1"
  end
end