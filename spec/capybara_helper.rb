def base_app_url
  "http://confer.dev"
end

def snap(page, file)
  page.driver.render("#{file}-#{Time.now.to_i}.png")
end

def sign_in(user)
  visit("/dev/log_in/#{user.email.split('@')[0]}")
end
