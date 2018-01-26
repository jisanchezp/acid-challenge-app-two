module Base64Helper
  require 'base64'

  # Encodes file to "urlsafe_base64" string, this allows the base64 string to
  # be send unaltered via JSON
  def file_to_base64(file)
    file_temp_path = file.tempfile.path
    Base64.encode64(File.open(file_temp_path, "rb").read)
  end

  # Decodes url safe base64 string and encodes it to the original base64 string
  def decode_urlsafe_to_original_base64(urlsafe_enconded_string)
    Base64.encode64(Base64.urlsafe_decode64(urlsafe_enconded_string))
  end
end
