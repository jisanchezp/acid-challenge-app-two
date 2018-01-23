class AuthenticationMailer < ApplicationMailer

  def authentication_email(email, status)
    @status = status
    mail( :to => email,
    :subject => 'Authentication - Acid Challenge' )
  end
end
