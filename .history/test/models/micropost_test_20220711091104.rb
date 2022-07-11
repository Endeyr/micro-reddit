require 'test_helper'

class MicropostTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "Example User", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do
    assert_raises(NameError) do
      assert @micropost.valid?
    end
  end

  test "user id should be present" do
    assert_raises(NameError) do
      @micropost.user_id = nil
      assert_not @micropost.valid?
    end
  end

  test "content should be present" do
    assert_raises(NameError) do
      @micropost.content = "   "
      assert_not @micropost.valid?
    end
  end

  test "content should be at most 140 characters" do
    assert_raises(NameError) do
      @micropost.content = "a" * 141
      assert_not @micropost.valid?
    end
  end

  test "order should be most recent first" do
    assert_equal microposts(:most_recent), Micropost.first
  end

  test "associated microposts should be destroyed" do
    @user.save
    @user.microposts.create!(content: "Lorem ipsum")
    assert_difference 'Micropost.count', -1 do
      @user.destroy
    end
  end
end
