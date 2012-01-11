require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @attr = { name: "Test User", email: "test@user.ru" }
    @user = users(:one)
  end

  test "should saved new user with valid attributes" do
    valid_user = User.create(@attr)
    assert valid_user.valid?
    assert valid_user.save
  end

  test "should not save user without name" do
    noname_user = User.new(@attr.merge(name: ""))
    assert_false noname_user.save
  end

  test "should not save user without email" do
    nomail_user = User.new(@attr.merge(email: ""))
    assert_false nomail_user.save
  end

  test "should not duplicate user" do
    User.create!(@attr)
    same_user = User.new(@attr)
    assert_false same_user.save
  end

  test "should have name with valid length [5..50]" do
    long = 'x'*51
    short = 'xxx'
    assert_false User.new(@attr.merge(:name => long)).valid?
    assert_false User.new(@attr.merge(:name => short)).valid?
  end

  test "should accept valid email addresses and reject invalid" do
    addr = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addr.each do |address|
      valid_user = User.new(@attr.merge(:email => address))
      assert valid_user.valid?
    end
    addr = %w[user@foo,com user_at_foo.org example.user@foo.]
    addr.each do |address|
      invalid_user = User.new(@attr.merge(:email => address))
      assert_false invalid_user.valid?
    end
  end

  # Testing associations
  test "should have a stories attribute" do
    assert_respond_to @user, :stories
  end

  test "should not destroy associated stories" do
    ids = @user.stories.map {|story| story.id}
    @user.destroy
    assert_equal Story.find(ids).count, ids.count
  end

end
