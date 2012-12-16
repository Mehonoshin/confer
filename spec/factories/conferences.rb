# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :conference do
    name "MyString"
    start_date "2012-12-16 14:00:47"
    end_date "2012-12-16 14:00:47"
    max_guests 1
  end
end
