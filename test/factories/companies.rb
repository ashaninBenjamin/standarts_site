# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :company do
    opf "opf"
    name
    #logo { fixture_file_upload('test.png', 'image/png', :true) }
  end
end