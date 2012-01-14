require 'test_helper'

class StoryTest < ActiveSupport::TestCase
  setup do
    @user = Factory(:user)
    @attr = { title: "Test Task", content: "Some text" }
  end

  test "should create new story" do
    story = @user.stories.create(@attr)
    assert story.save
  end

  test "should have user attribute" do
    story = @user.stories.create(@attr)
    assert_respond_to story, :user
  end

  test "should have the right associated user" do
    story = @user.stories.create(@attr)
    assert_equal story.user_id, @user.id
    assert_equal story.user, @user
  end

  test "should have defaults scope by created_at ASC" do
    story1 = Factory(:story, created_at: 1.day.ago)
    story2 = Factory(:story, created_at: 2.day.ago)
    assert_equal Story.all, [story2, story1]
  end

  test "should delete it comments on destroy" do
    story = Factory(:story)
    foreign_comment = Factory(:comment)
    own_comment = story.comments.create!(content: "Test")
    story.destroy
    assert_equal Comment.find(foreign_comment), foreign_comment
    assert_raise(ActiveRecord::RecordNotFound) { Comment.find(own_comment) }
  end

  #State full_name tests
  test "should have available states and new state on init" do
    assert Story.states
    story = Story.new(@attr)
    assert_not_nil story.state
    assert_equal story.state.name.to_s, "new"
  end
  test "should saved state in db" do
    story = Story.new(@attr)
    before_save_id = story.state.id
    story.save
    assert_equal before_save_id, Story.find(story).state.id
  end
  test "should have right state pare" do
    story = Factory.create(:story)
    story.state_id = State.all.sample.id
    assert_equal State.new(story.state.id).name, story.state.name
  end
  test "should have right getter and setter" do
    story = Factory.create(:story)
    story.state_id = Story.states.sample.id
    assert_equal story.state.id, story.state_id
  end

end
