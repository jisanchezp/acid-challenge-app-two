require 'test_helper'
require 'faker'
require 'base64'

class Rest::SessionsControllerTest < ActionDispatch::IntegrationTest
  include Base64Helper

  setup do
    @user_one = users(:one)
    @email = Faker::Internet.free_email
    @user_agent = Faker::Internet.user_agent
    @request_headers =  {
                          'Content-Type' => 'application/json',
                          'User-Agent' => @user_agent
                        }
    @uploaded_file_one =  Rack::Test::UploadedFile.new (Rails.root.join("test/files/test.png")), 'image/png'
    @uploaded_file_two =  Rack::Test::UploadedFile.new (Rails.root.join("test/files/test2.png")), 'image/png'
    @request_body_one = { image: "#{Base64.urlsafe_encode64(File.open(@uploaded_file_one.tempfile, "rb").read).to_json}" }.to_json
    @request_body_two = { image: "#{Base64.urlsafe_encode64(File.open(@uploaded_file_two.tempfile, "rb").read).to_json}" }.to_json
    @authorized_response_body = { message: "OK" }.to_json
    @unauthorized_response_body = { message: "No Autorizado" }.to_json
  end

  #email: does exists in DB
  #image: doesn't match DB record
  test "should return status 200 user authorized" do

    post rest_path(email: @user_one.email),  params: @request_body_two,
                          headers: @request_headers

    assert_response 200
    assert_equal @authorized_response_body, @response.body
  end

  #email: doesn't exists in DB
  #image: does exists in DB
  test "should return status 401 user doesnt exists" do

    post rest_path(email: @email),  params: @request_body_one,
                          headers: @request_headers

    assert_response 401
    assert_equal @unauthorized_response_body, @response.body
  end

  #email: does exists in DB
  #image: matches DB record
  test "should return status 401 user unauthorized" do

    post rest_path(email: @user_one.email),  params: @request_body_one,
                          headers: @request_headers

    assert_response 401
    assert_equal @unauthorized_response_body, @response.body
  end
end
