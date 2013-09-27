require 'test_helper'

class GathasControllerTest < ActionController::TestCase
  setup do
    @gatha = gathas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:gathas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create gatha" do
    assert_difference('Gatha.count') do
      post :create, gatha: { index: @gatha.index, vagga_id: @gatha.vagga_id }
    end

    assert_redirected_to gatha_path(assigns(:gatha))
  end

  test "should show gatha" do
    get :show, id: @gatha
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @gatha
    assert_response :success
  end

  test "should update gatha" do
    patch :update, id: @gatha, gatha: { index: @gatha.index, vagga_id: @gatha.vagga_id }
    assert_redirected_to gatha_path(assigns(:gatha))
  end

  test "should destroy gatha" do
    assert_difference('Gatha.count', -1) do
      delete :destroy, id: @gatha
    end

    assert_redirected_to gathas_path
  end
end
