# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    login "login"
    password "123"
    profile
    company
    role
  end

  factory :super_user, class: User do
    login "admin"
    password "123"
    profile
    company
    association :role, factory: :super_role
  end

  factory :sign_in_user, class: UserSignInType do
    login "login"
    password "123"
  end

end