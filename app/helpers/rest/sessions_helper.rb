module Rest::SessionsHelper

  # Returns a 401 response if the received image and the store one are the same.
  def verify_session(email, image)

    user = User.find_by_email(email)

    unless user.nil?
      if user.image == image
        return response_hash(false)
      else
        return response_hash(true)
      end
    end

    return response_hash(false, false)
  end


  private

    def response_hash(isAuthorized, exists = true)
      if !isAuthorized
        return {status: 401, message: "No Autorizado", exists: exists}
      end

      return {status: 200, message: "OK", exists: exists}
    end
end
