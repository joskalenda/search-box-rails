require "test_helper"

class CachesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cach = caches(:one)
  end

  test "should get index" do
    get caches_url
    assert_response :success
  end

  test "should get new" do
    get new_cach_url
    assert_response :success
  end

  test "should create cach" do
    assert_difference("Cach.count") do
      post caches_url, params: { cach: {  } }
    end

    assert_redirected_to cach_url(Cach.last)
  end

  test "should show cach" do
    get cach_url(@cach)
    assert_response :success
  end

  test "should get edit" do
    get edit_cach_url(@cach)
    assert_response :success
  end

  test "should update cach" do
    patch cach_url(@cach), params: { cach: {  } }
    assert_redirected_to cach_url(@cach)
  end

  test "should destroy cach" do
    assert_difference("Cach.count", -1) do
      delete cach_url(@cach)
    end

    assert_redirected_to caches_url
  end
end
