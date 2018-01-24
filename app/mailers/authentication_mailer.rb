class AuthenticationMailer < ApplicationMailer

  def authentication_email(email, status, user_agent)
    @status = status
    @user_agent = user_agent
    mail( :to => email,
    :subject => 'Authentication - Acid Challenge' )
  end
end
