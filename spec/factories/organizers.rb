# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :organizer do
    user_id 1
    conference_id 1
    role "MyString"
    role_description "MyString"
  end
end
