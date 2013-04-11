# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user, class: UserCreateType do
    login "login"
    password "123"
    association :profile
    association :company
    association :role
  end

  factory :super_user, class: UserCreateType do
    login "admin"
    password "123"
    association :profile
    association :company
    association :role, factory: :super_role
  end

end