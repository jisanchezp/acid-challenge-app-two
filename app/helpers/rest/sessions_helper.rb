module Rest::SessionsHelper

  def verify_session(email, image)

    User.all.each do |user|
      if user.email.downcase == email.downcase
        if user.image == image
          return response_hash(false)
        else
          return response_hash(true)
        end
      end
    end

    return response_hash(false)
  end


  private

    def response_hash(isAuthorized)
      if !isAuthorized
        return {status: 401, message: "No Autorizado"}
      end

      return {status: 200, message: "OK"}
    end
end
