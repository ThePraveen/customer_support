FactoryGirl.define do
  factory :user do
    name "John"
    nickname "John"
    email "john@mailinator.com"
    password "password"
    password_confirmation "password"
  end

  factory :user1 do
    name "John1"
    nickname "John1"
    email "john1@mailinator.com"
    password "password"
    password_confirmation "password"
  end

end
