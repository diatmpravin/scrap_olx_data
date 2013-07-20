require 'test_helper'

class WagonrsControllerTest < ActionController::TestCase
  setup do
    @wagonr = wagonrs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:wagonrs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create wagonr" do
    assert_difference('Wagonr.count') do
      post :create, wagonr: { Mileage: @wagonr.Mileage, base_link: @wagonr.base_link, model: @wagonr.model, name: @wagonr.name, olx_id: @wagonr.olx_id, posted_date: @wagonr.posted_date, price: @wagonr.price }
    end

    assert_redirected_to wagonr_path(assigns(:wagonr))
  end

  test "should show wagonr" do
    get :show, id: @wagonr
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @wagonr
    assert_response :success
  end

  test "should update wagonr" do
    patch :update, id: @wagonr, wagonr: { Mileage: @wagonr.Mileage, base_link: @wagonr.base_link, model: @wagonr.model, name: @wagonr.name, olx_id: @wagonr.olx_id, posted_date: @wagonr.posted_date, price: @wagonr.price }
    assert_redirected_to wagonr_path(assigns(:wagonr))
  end

  test "should destroy wagonr" do
    assert_difference('Wagonr.count', -1) do
      delete :destroy, id: @wagonr
    end

    assert_redirected_to wagonrs_path
  end
end
