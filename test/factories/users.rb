# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    login "login"
    password "123"
    password_confirmation "123"
    association :user_info
    association :company
    association :role
  end

  factory :super_user, class: User do
    login "admin"
    password "123"
    password_confirmation "123"
    association :user_info
    association :company
    association :role, factory: :super_role
  end

  factory :user_just_created, class: User do
    login "login"
    password "123"
    password_confirmation "123"
  end
end