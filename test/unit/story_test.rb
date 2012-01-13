require 'test_helper'

class StoryTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
    @attr = { title: "Test Task", content: "Some text" }
  end

  test "should create new story" do
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
    assert_equal Story.all, [story2, story1]
  end

  #State full_name tests
  test "should have available states and new state on init" do
    story = Story.new
    assert State.all
    assert_not_nil story.state
    assert_equal story.state.name.to_s, "new"
  end
  test "should have right state pare" do
    story = Factory.create(:story)
    story.state_id = State.all.sample.id
    assert_equal State.new(story.state.id).name, story.state.name
  end
  #test "should have right state_name associated with state" do
  #  story = stories(:one).find
  #  assert_equal Story::STATE_TABLE(story.state_name), story.state
  #end


end
