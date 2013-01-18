def base_app_url
  "http://confer.dev"
end

def project_url(domain)
  "http://#{domain}.confer.dev:8097"
end

def snap(page, file)
  page.driver.render("#{file}-#{Time.now.to_i}.png")
end

def sign_in(user)
  visit("#{base_app_url}:8097/dev/log_in/#{user.email.split('@')[0]}")
end
