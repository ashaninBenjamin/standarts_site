FactoryGirl.define do
  sequence :content do |n|
    "content#{n}"
  end

  sequence :surname do |n|
    "surname#{n}"
  end

  sequence :name do |n|
    "name #{n}"
  end

  sequence :mail do |n|
    "persons#{n}@example.com"
  end

  sequence :title do |n|
    "Title #{n}"
  end
end