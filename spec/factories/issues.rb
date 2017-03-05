FactoryGirl.define do
  factory :issue do
    customer_id 1
    executive_id nil
    status "created"
    title "Not able to start"
    description "It's very complicated"
  end
end
