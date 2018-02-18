require 'test_helper'

class ShowslistsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @showslist = showslists(:one)
  end

  test "should get index" do
    get showslists_url
    assert_response :success
  end

  test "should get new" do
    get new_showslist_url
    assert_response :success
  end

  test "should create showslist" do
    assert_difference('Showslist.count') do
      post showslists_url, params: { showslist: { filename: @showslist.filename, last_modified: @showslist.last_modified, length: @showslist.length, live_date: @showslist.live_date, live_place: @showslist.live_place, live_pref: @showslist.live_pref, name: @showslist.name, playtime: @showslist.playtime, title: @showslist.title } }
    end

    assert_redirected_to showslist_url(Showslist.last)
  end

  test "should show showslist" do
    get showslist_url(@showslist)
    assert_response :success
  end

  test "should get edit" do
    get edit_showslist_url(@showslist)
    assert_response :success
  end

  test "should update showslist" do
    patch showslist_url(@showslist), params: { showslist: { filename: @showslist.filename, last_modified: @showslist.last_modified, length: @showslist.length, live_date: @showslist.live_date, live_place: @showslist.live_place, live_pref: @showslist.live_pref, name: @showslist.name, playtime: @showslist.playtime, title: @showslist.title } }
    assert_redirected_to showslist_url(@showslist)
  end

  test "should destroy showslist" do
    assert_difference('Showslist.count', -1) do
      delete showslist_url(@showslist)
    end

    assert_redirected_to showslists_url
  end
end
