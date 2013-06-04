require 'test_helper'

class OmadusedsControllerTest < ActionController::TestCase
  setup do
    @omadused = omaduseds(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:omaduseds)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create omadused" do
    assert_difference('Omadused.count') do
      post :create, omadused: { KOOSTIS: @omadused.KOOSTIS, MYYGILOA_HOIDJA: @omadused.MYYGILOA_HOIDJA, MYYGILOA_KUUPAEV: @omadused.MYYGILOA_KUUPAEV, MYYGILOA_NUMBER: @omadused.MYYGILOA_NUMBER, RAVIMPREPARAADI_NIMETUS: @omadused.RAVIMPREPARAADI_NIMETUS, RAVIMVORM: @omadused.RAVIMVORM, TEKSTI_LABIVAATAMISE_KUUPAEV: @omadused.TEKSTI_LABIVAATAMISE_KUUPAEV, abiained: @omadused.abiained, annustamine: @omadused.annustamine, atc: @omadused.atc, farmakodynaamilised: @omadused.farmakodynaamilised, farmakokineetilised: @omadused.farmakokineetilised, havitamine: @omadused.havitamine, hoiatused: @omadused.hoiatused, kolblikkusaeg: @omadused.kolblikkusaeg, koostoimed: @omadused.koostoimed, korvaltoimed: @omadused.korvaltoimed, naidustused: @omadused.naidustused, pakendi_iseloomustus: @omadused.pakendi_iseloomustus, prekliinilised: @omadused.prekliinilised, rasedus: @omadused.rasedus, reaktsioonikiirus: @omadused.reaktsioonikiirus, sailitamine: @omadused.sailitamine, sobimatus: @omadused.sobimatus, spc: @omadused.spc, toimeaine: @omadused.toimeaine, vastunaidustused: @omadused.vastunaidustused, yleannustamine: @omadused.yleannustamine }
    end

    assert_redirected_to omadused_path(assigns(:omadused))
  end

  test "should show omadused" do
    get :show, id: @omadused
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @omadused
    assert_response :success
  end

  test "should update omadused" do
    put :update, id: @omadused, omadused: { KOOSTIS: @omadused.KOOSTIS, MYYGILOA_HOIDJA: @omadused.MYYGILOA_HOIDJA, MYYGILOA_KUUPAEV: @omadused.MYYGILOA_KUUPAEV, MYYGILOA_NUMBER: @omadused.MYYGILOA_NUMBER, RAVIMPREPARAADI_NIMETUS: @omadused.RAVIMPREPARAADI_NIMETUS, RAVIMVORM: @omadused.RAVIMVORM, TEKSTI_LABIVAATAMISE_KUUPAEV: @omadused.TEKSTI_LABIVAATAMISE_KUUPAEV, abiained: @omadused.abiained, annustamine: @omadused.annustamine, atc: @omadused.atc, farmakodynaamilised: @omadused.farmakodynaamilised, farmakokineetilised: @omadused.farmakokineetilised, havitamine: @omadused.havitamine, hoiatused: @omadused.hoiatused, kolblikkusaeg: @omadused.kolblikkusaeg, koostoimed: @omadused.koostoimed, korvaltoimed: @omadused.korvaltoimed, naidustused: @omadused.naidustused, pakendi_iseloomustus: @omadused.pakendi_iseloomustus, prekliinilised: @omadused.prekliinilised, rasedus: @omadused.rasedus, reaktsioonikiirus: @omadused.reaktsioonikiirus, sailitamine: @omadused.sailitamine, sobimatus: @omadused.sobimatus, spc: @omadused.spc, toimeaine: @omadused.toimeaine, vastunaidustused: @omadused.vastunaidustused, yleannustamine: @omadused.yleannustamine }
    assert_redirected_to omadused_path(assigns(:omadused))
  end

  test "should destroy omadused" do
    assert_difference('Omadused.count', -1) do
      delete :destroy, id: @omadused
    end

    assert_redirected_to omaduseds_path
  end
end
