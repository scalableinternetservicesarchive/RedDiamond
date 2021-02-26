require "test_helper"

class GroupTest < ActiveSupport::TestCase
  test 'requires maximum to be at least 2' do
    group = build(:group, max_member_count: 1)

    assert_not group.valid?
    assert group.errors[:max_member_count].present?
  end
end
