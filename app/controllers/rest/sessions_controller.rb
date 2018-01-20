class Rest::SessionsController < ActionController::API
  include Rest::SessionsHelper

  def verify
    email = params[:email]
    image = params[:image]

    validation_response = verify_session(email, image)

    render json: { status: validation_response[:status],
      message: validation_response[:message]
    }.to_json
  end
end
