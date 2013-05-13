require 'test_helper'

class StandardTest < ActiveSupport::TestCase
  def setup
    @user = create :user
    root = create :root_standard, user: @user
    @standard = create :standard, user: @user, parent: root
    @children = create :standard, user: @user, parent: @standard
  end

  test "find_standard_node_numbers" do
    assert (@standard.node_numbers == [2])
  end

  test "find_child_node_numbers" do
    assert (@children.node_numbers == [1])
  end
end
