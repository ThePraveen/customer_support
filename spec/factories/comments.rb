FactoryGirl.define do
  factory :comment do
    referenced ""
    body "MyText"
    issue nil
  end
end
