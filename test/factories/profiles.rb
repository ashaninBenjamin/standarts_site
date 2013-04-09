# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :profile do
    surname
    name
    mail
    #avatar { fixture_file_upload('test.png', 'image/png', :true) }
  end
end