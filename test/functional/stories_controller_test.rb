require 'test_helper'

class StoriesControllerTest < ActionController::TestCase
  setup do
    @story = Factory.create(:story)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:stories)
  end

  test "should get right title" do
    get :index
    assert_select 'title', "List of Stories | TaskManager"
    assert_select 'h1', "List of Stories"
  end

  test "should render filter by user" do
    users = Factory.create_list(:users,5)
    get :index
    assert_not_nil assigns(:users)
    User.each do |user|
      assert_select 'a'
    end

  end




  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create story" do
    assert_difference('Story.count') do
      post :create, story: @story.attributes
    end

    assert_redirected_to story_path(assigns(:story))
  end

  test "should show story" do
    get :show, id: @story.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @story.to_param
    assert_response :success
  end

  test "should update story" do
    put :update, id: @story.to_param, story: @story.attributes
    assert_redirected_to story_path(assigns(:story))
  end

  test "should destroy story" do
    assert_difference('Story.count', -1) do
      delete :destroy, id: @story.to_param
    end

    assert_redirected_to stories_path
  end
end
