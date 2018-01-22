class Rest::SessionsController < ActionController::API
  include Rest::SessionsHelper
  include Base64Helper

  def verify
    email = params[:email]
    image = decode_urlsafe_to_original_base64(params[:image])
    validation_response = verify_session(email, image)
    render status: validation_response[:status],
      json: {
        message: validation_response[:message]
      }.to_json
  end
end
