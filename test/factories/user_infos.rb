# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_info do
    surname
    name
    mail
    #avatar { fixture_file_upload('test.png', 'image/png', :true) }
  end
end