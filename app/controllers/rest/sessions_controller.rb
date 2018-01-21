class Rest::SessionsController < ActionController::API
  include Rest::SessionsHelper

  def verify
    email = params[:email]
    image = params[:image]

    validation_response = verify_session(email, image)

    render status: validation_response[:status],
      json: {
        message: validation_response[:message]
      }.to_json
  end
end
