require 'test_helper'
require 'faker'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_one = users(:one)
    @uploaded_file =  Rack::Test::UploadedFile.new (Rails.root.join("test/files/test.png")), 'image/png'
  end

  test "should get index" do
    get users_url
    assert_response :success
  end

  test "user get new" do
    get new_user_url
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do

      post users_url, params: { user:
                                {
                                  email: Faker::Internet.free_email,
                                  image: "place_holder",
                                  image_file: @uploaded_file
                                }
                              }
    end

    assert_redirected_to users_url
  end

  test "should not create user due to existings email" do
    assert_difference 'User.count', 0  do
      post users_url, params: { user:
                                {
                                  email: @user_one.email,
                                  image: "place_holder",
                                  image_file: @uploaded_file
                                }
                              }
    end

    assert_template :new
  end

  test "should get edit" do
    get edit_user_url(@user_one)
    assert_response :success
  end

  test "should update user" do

    patch user_url(@user_one), params: { user:
                                          {
                                            email: @user_one.email,
                                            image: "asdsad",
                                            image_file: @uploaded_file
                                          }
                                        }
    assert_redirected_to users_url
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete user_url(@user_one)
    end

    assert_redirected_to users_url
  end
end
