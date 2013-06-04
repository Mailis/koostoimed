require 'test_helper'

class AtcsControllerTest < ActionController::TestCase
  setup do
    @atc = atcs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:atcs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create atc" do
    assert_difference('Atc.count') do
      post :create, atc: { code: @atc.code, nimetus_eng: @atc.nimetus_eng, nimetus_est: @atc.nimetus_est }
    end

    assert_redirected_to atc_path(assigns(:atc))
  end

  test "should show atc" do
    get :show, id: @atc
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @atc
    assert_response :success
  end

  test "should update atc" do
    put :update, id: @atc, atc: { code: @atc.code, nimetus_eng: @atc.nimetus_eng, nimetus_est: @atc.nimetus_est }
    assert_redirected_to atc_path(assigns(:atc))
  end

  test "should destroy atc" do
    assert_difference('Atc.count', -1) do
      delete :destroy, id: @atc
    end

    assert_redirected_to atcs_path
  end
end
