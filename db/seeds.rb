admin = User.create(email: "admin@vsuconf.ru", password: "1234567")
admin.confirm!
admin.admin!

25.times do
  user = FactoryGirl.create(:user)
  user.confirm!
end

25.times do
  FactoryGirl.create(:conference, user_id: User.last.id)
end
