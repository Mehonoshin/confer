# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :conference do
    sequence(:name) { |n| "MyString #{n}" }
    sequence(:domain) { |n| "conf#{n}" }
    start_date Time.now.tomorrow
    end_date 10.days.since
    max_guests 1
    user_id 1
    modules ["news", "participants", "reports", "contacts"]
  end
  factory :invalid_conference, parent: :conference do
    name nil
  end
end
