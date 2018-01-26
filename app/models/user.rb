class User < ApplicationRecord
  include Base64Helper
  attr_accessor :image_file
  before_save { |user| user.image = file_to_base64(user.image_file) }
  before_save { email.downcase! }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :image, presence: true


end
