class FeedbackMailer < ActionMailer::Base
  default from: "no-reply@vsuconf.ru"

  def new_feedback(notification_email, title, body, customer, conference)
    @title, @body, @customer, @conference = title, body, customer, conference
    mail(to: notification_email, subject: t('projects.feedbacks.subject'))
  end
end
