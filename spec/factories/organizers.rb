# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :organizer do
    user_id 1
    conference_id 1
    role "owner"
    role_description "Some descr"
  end
  factory :organizer_by_email, parent: :organizer do
    user_id nil
  end
end
