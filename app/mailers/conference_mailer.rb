class ConferenceMailer < ActionMailer::Base
  default from: "no-reply@vsuconf.ru"

  def conference_approved(conference, creator)
    @conference, @user = conference, creator.user
    mail(to: creator.user.email, subject: t("conference.mailer.conference_approved.subject"))
  end

  def participation_approved(conference, user)
    @conference, @user = conference, user
    mail(to: user.email, subject: t('conference.mailer.participation_approved.subject'))
  end

end
