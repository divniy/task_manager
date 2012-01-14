require 'test_helper'

class StoriesControllerTest < ActionController::TestCase
  #include Factory::Syntax::Methods
  setup do
    FactoryGirl.create_list(:application_user, 5)
    8.times {
      FactoryGirl.create(:application_story, :user_id => "#{User.all.sample.id}")
    }
    @story = FactoryGirl.create(:story)
  end

  #Index

  test "should get index" do
    get :index
    assert_response :success
    assert_template 'stories/index'
    assert_template 'shared/_filters'
    assert_not_nil assigns(:stories)
  end

  test "should get right title List" do
    get :index
    assert_select 'title', "List of Stories | TaskManager"
    assert_select 'h1', "List of Stories"
  end

  test "should render filter by user" do
    get :index
    assert_not_nil assigns(:users)
    assert_select '.sidebar' do
      User.all.each do |user|
        assert_select 'a', user.full_name
      end
    end
  end

  test "should filtered by user" do
    User.all.each { |user|
      get :index, :by => :user, :id => user.id
      assert_equal assigns(:stories), user.stories
    }
  end

  test "should render filter by state" do
    get :index
    assert assigns(:states)
    assert_select '.sidebar' do
      Story.states.each do |state|
        assert_select 'a', state.name.to_s
      end
    end
  end

  test "should filtered by state" do
    Story.states.each { |state|
      get :index, :by => :state, :id => state.id
      assert_equal assigns(:stories), Story.find_all_by_state(state)
    }
  end

  #New

  test "should get new" do
    get :new
    assert_response :success
    assert_template 'stories/new'
  end

  test "should get right title New" do
    get :index
    assert_select 'title', "New Story | TaskManager"
    assert_select 'h1', "New Story"
  end

    #Create

    test "should create story" do
      assert_difference('Story.count') do
        post :create, story: Factory.attributes_for(:story)
      end
      assert_redirected_to stories_path
    end

    test "should decline story with short fields" do
      assert_difference('Story.count', 0) do
        post :create, story: @story.tap {|s| s.title = ""}.attributes
        post :create, story: @story.tap {|s| s.content = ""}.attributes
      end
      assert assigns(:story)
      assert_template 'stories/new'
      assert_response :success
    end

  #Show

  test "should show story" do
    get :show, id: @story.to_param
    assert assigns(:story)
    assert assigns(:comments)
    assert_template 'stories/show'
    assert_template 'comments/form'
    assert_response :success
  end

    #Edit

    test "should get edit" do
      get :edit, id: @story.to_param
      assert_response :success
    end

    test "should have fields with right content" do
      flunk
    end

    test "should update story" do
      put :update, id: @story.to_param, story: @story.attributes
      assert_redirected_to story_path(assigns(:story))
    end

  #Destroy

  test "should destroy story" do
    assert_difference('Story.count', -1) do
      delete :destroy, id: @story.to_param
    end
    assert_redirected_to stories_path
  end
end
