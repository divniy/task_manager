require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @attr = { full_name: "Test User", email: "dasd@desr.ru"}
    @user = Factory.create(:user)
  end

  test "should saved new user with valid attributes" do
    valid_user = User.create(@attr)
    assert valid_user.valid?
    assert valid_user.save
  end

  test "should not save user without full_name" do
    noname_user = User.new(@attr.merge(full_name: ""))
    assert_false noname_user.save
  end

  test "should not save user without email" do
    nomail_user = User.new(@attr.merge(email: ""))
    assert_false nomail_user.save
  end

  test "should not duplicate user" do
    Factory.create(:user, email: 'fixed@mail.com')
    assert_false Factory.build(:user, email: 'fixed@mail.com').save
  end

  test "should have full_name with valid length [5..50]" do
    long = 'x'*51
    short = 'xxx'
    assert_false Factory.build(:user, :full_name => long).valid?
    assert_false Factory.build(:user, :full_name => short).valid?
  end

  test "should accept valid email addresses and reject invalid" do
    addr = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addr.each do |valid_address|
      assert Factory.build(:user, email: valid_address).valid?
    end
    addr = %w[user@foo,com user_at_foo.org example.user@foo.]
    addr.each do |invalid_address|
      assert_false Factory.build(:user, email: invalid_address).valid?
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
