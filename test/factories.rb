# This will guess the User class
# built_users   = FactoryGirl.build_list(:user, 25)
# created_users = FactoryGirl.create_list(:user, 25)

FactoryGirl.define do

  sequence :email do |n|
    "person#{n}@example.com"
  end

  factory :user do
    full_name  { "Test User 1" }
    email
  end

  factory :application_user, :parent => :user do
    full_name  { Faker::Name.name }
    email      { Faker::Internet.email }
    created_at { (rand(2).days + rand(24).hours + rand(60).minutes).ago }
  end

  factory :story do
    user
    title      { "Test Title" }
    content    { "Test content" }
    state      { State.new(1) }
  end

  factory :application_story, :parent => :story do
    title      { Faker::Lorem.sentence(2) }
    content    { Faker::Lorem.paragraphs(7).join() }
    state      { State.all.sample }
    created_at { (rand(2).days + rand(24).hours + rand(60).minutes).ago }
  end

  #State.all.sample.id
  factory :comment do
    story
    content    { "Test 1" }
  end

  factory :application_comment, :parent => :comment do
    content    { Faker::Lorem.paragraph(4) }
    created_at { (rand(2).days + rand(24).hours + rand(60).minutes).ago }
  end

end