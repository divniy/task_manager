require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  test "should have defaults scope by created_at ASC" do
    story1 = Factory(:comment, created_at: 1.day.ago)
    story2 = Factory(:comment, created_at: 2.day.ago)
    assert_equal Comment.all, [story2, story1]
  end
end
