class GroupMembership < ApplicationRecord
  belongs_to :user, touch: true
  belongs_to :group, touch: true
end
