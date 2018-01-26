require 'test_helper'
require 'faker'

class UserTest < ActiveSupport::TestCase

  def setup
    @uploaded_file =  Rack::Test::UploadedFile.new (Rails.root.join("test/files/test.png")), 'image/png'
    @user = User.new( email: Faker::Internet.free_email, image: "place_holder",
      image_file: @uploaded_file )
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "email should be present" do
    @user.email = "   "
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 248 + "@example.com"
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = ["#{Faker::Internet.email}", "#{Faker::Internet.free_email}",
                       "#{Faker::Internet.email}", "#{Faker::Internet.free_email}",
                       "#{Faker::Internet.email}", "#{Faker::Internet.free_email}"]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email address should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email address should be saved as lower-case" do
    mixed_case_email = "JuaNcHo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "image should be base64 string of image_file" do
    assert_equal "place_holder", @user.image
    @user.save
    assert_equal Base64.encode64(File.open(@uploaded_file, 'rb').read), @user.reload.image
  end
end
