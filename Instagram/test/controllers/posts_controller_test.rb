require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "should get index" do
    get root_url
    assert_response :success
    assert_select "h1", "Tu feed"
    assert_select ".post-card", 2
  end

  test "should get new" do
    sign_in users(:one)

    get new_post_url
    assert_response :success
    assert_select "textarea.form-control[name=?]", "post[description]"
    assert_select "input.form-control[type=file][name=?]", "post[image]"
  end

  test "should get show" do
    get post_url(posts(:one))
    assert_response :success
    assert_select "h1", posts(:one).user.email
  end

  test "should render the sign in page with Bootstrap form controls" do
    get new_user_session_url

    assert_response :success
    assert_select ".auth-card"
    assert_select "input.form-control[name=?]", "user[email]"
  end

  test "should render the registration page with Bootstrap form controls" do
    get new_user_registration_url

    assert_response :success
    assert_select ".auth-card"
    assert_select "input.form-control[name=?]", "user[password_confirmation]"
  end

  test "should show Bootstrap validation feedback when a post is invalid" do
    sign_in users(:one)

    post posts_url, params: { post: { description: "muy corto" } }

    assert_response :unprocessable_entity
    assert_select ".alert-danger"
  end
end
