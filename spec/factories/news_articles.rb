# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :news_article do
    title "MyString"
    body "MyText"
    conference_id 1
    participant_id 999
  end
end
