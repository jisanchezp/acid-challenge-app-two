# Preview all emails at http://localhost:3000/rails/mailers/authentication_mailer
class AuthenticationMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/authentication_mailer/authentication_email
  def authentication_email
    AuthenticationMailer.authentication_email
  end

end
