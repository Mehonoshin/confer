# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :feedback do
    user_id 1
    email "mail@example.com"
    title "MyString"
    body "MyText"
    conference_id 1
    state "unread"
  end
end
