class Rest::SessionsController < ActionController::API

  def verify
    render json: { status: 200,
      message: "OK"
    }.to_json
  end
end
