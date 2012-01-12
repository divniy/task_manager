# This will guess the User class
# built_users   = FactoryGirl.build_list(:user, 25)
# created_users = FactoryGirl.create_list(:user, 25)

FactoryGirl.define do

  factory :user do
    full_name      { Faker::Name.name }
    email     { Faker::Internet.email }
  end

  factory :story do
    user
    title     { Faker::Lorem.sentence(4) }
    content   { Faker::Lorem.paragraphs(2) }
  end

end