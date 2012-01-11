require 'test_helper'

class StoryTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
    @attr = { title: "Test Task", content: "Some text" }
  end

  test "should create new task" do
    story = @user.stories.create(@attr)
    assert story.save
  end

  test "should have user attribute" do
    story = stories(:one)
    assert_respond_to story, :user
  end

  test "should have the right associated user" do
    story = @user.stories.create(@attr)
    assert_equal story.user_id, @user.id
    assert_equal story.user, @user
  end

  test "should have defaults scope by created_at DESC" do
    story1 = stories(:one)
    story2 = stories(:two)
    assert_equal(Story.all,[story2, story1])
  end

  #State name tests
  test "should have right state_name associated with state" do

  end
  test "should have 'new' state_name "


end
