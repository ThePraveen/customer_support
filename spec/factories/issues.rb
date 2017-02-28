FactoryGirl.define do
  factory :issue do
    customer nil
    executive nil
    issue_type nil
    status "MyString"
    title "MyText"
    description "MyText"
  end
end
