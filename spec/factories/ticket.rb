FactoryGirl.define do 
  
  factory :ticket do 
    title         Faker::Company.bs
    description   Faker::Lorem.paragraph
  end

end