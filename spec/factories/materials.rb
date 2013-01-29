# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :material do
    file { File.open(Rails.root.join("spec", "fixtures", "files", "gerb.gif")) }
    name "MyString"
    conference_id 1
    user_id 1
  end
end
