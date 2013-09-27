require 'test_helper'

class VaggasControllerTest < ActionController::TestCase
  setup do
    @vagga = vaggas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:vaggas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create vagga" do
    assert_difference('Vagga.count') do
      post :create, vagga: { book_id: @vagga.book_id, index: @vagga.index }
    end

    assert_redirected_to vagga_path(assigns(:vagga))
  end

  test "should show vagga" do
    get :show, id: @vagga
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @vagga
    assert_response :success
  end

  test "should update vagga" do
    patch :update, id: @vagga, vagga: { book_id: @vagga.book_id, index: @vagga.index }
    assert_redirected_to vagga_path(assigns(:vagga))
  end

  test "should destroy vagga" do
    assert_difference('Vagga.count', -1) do
      delete :destroy, id: @vagga
    end

    assert_redirected_to vaggas_path
  end
end
