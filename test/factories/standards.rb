# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :standard do
    number 1
    name
    content
  end

  factory :one_another_standard, class: Standard do
    number 2
    name
    content
  end
end