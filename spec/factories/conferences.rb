# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :conference do
    name "MyString"
    sequence(:domain) { |n| "conf#{n}" }
    start_date "2012-12-16 14:00:47"
    end_date "2012-12-16 14:00:47"
    max_guests 1
    user_id 1
  end
  factory :invalid_conference, parent: :conference do
    name nil
  end
end
