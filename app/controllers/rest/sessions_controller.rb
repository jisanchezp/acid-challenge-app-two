class Rest::SessionsController < ActionController::API
  include Rest::SessionsHelper
  include Base64Helper

  def verify
    email = params[:email].downcase
    image = decode_urlsafe_to_original_base64(params[:image])

    # Verify session and return response status and message
    validation_response = verify_session(email, image)

    if validation_response[:exists]

      # Send notification email
      result = AuthenticationMailer.authentication_email(
        email,
        validation_response[:status]
      ).deliver_now!
    end

    # Return response
    render status: validation_response[:status],
      json: {
        message: validation_response[:message]
      }.to_json
  end
end
