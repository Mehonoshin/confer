# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :report do
    participant_id 1
    conference_id 1
    title "MyString"
    description "MyText"
  end
end
