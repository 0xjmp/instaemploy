class AlertMailer < ApplicationMailer

  def skill_found(alert)
    @alert = alert
    mail(to: alert.email, subject: I18n.t('mailer.skill_found'))
  end

end