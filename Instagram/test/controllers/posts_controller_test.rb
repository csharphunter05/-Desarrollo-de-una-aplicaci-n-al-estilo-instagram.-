require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "should get index" do
    get root_url
    assert_response :success
    assert_select "h1", "Instagram"
  end

  test "should get new" do
    sign_in users(:one)

    get new_post_url
    assert_response :success
    assert_select "textarea[name=?]", "post[description]"
    assert_select "input[type=file][name=?]", "post[image]"
  end

  test "should get show" do
    get post_url(posts(:one))
    assert_response :success
    assert_select "h2", "Publicación"
  end
end
