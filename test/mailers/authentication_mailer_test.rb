require 'test_helper'

class AuthenticationMailerTest < ActionMailer::TestCase
  test "authentication_email" do
    mail = AuthenticationMailer.authentication_email
    assert_equal "Authentication email", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
