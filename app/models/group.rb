class Group < ApplicationRecord
  validates :max_member_count, numericality: { greater_than_or_equal_to: 2 }

  belongs_to :game
  has_many :group_memberships
  has_many :users, through: :group_memberships

  alias_attribute :members, :users
end
