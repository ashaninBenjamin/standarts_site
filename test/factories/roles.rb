# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :role do
    name "admin"
    description "administrator"
  end

  factory :super_role, class: Role do
    name "super"
    description "super administrator"
  end
end