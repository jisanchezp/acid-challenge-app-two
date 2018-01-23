class AuthenticationMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.authentication_mailer.authentication_email.subject
  #
  def authentication_email(email, status)
    @status = status
    mail( :to => email,
    :subject => 'Authentication - Acid Challenge' )
  end
end
