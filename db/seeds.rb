admin = User.create(email: "admin@vsuconf.ru", password: "1234567")
admin.confirm!
admin.admin!

25.times do
  user = FactoryGirl.create(:user)
  user.confirm!
end

15.times do
  FactoryGirl.create(:conference, user_id: User.last.id, start_date: Time.now.tomorrow, end_date: 2.days.from_now)
end

15.times do
  FactoryGirl.create(:conference, user_id: User.last.id)
end
