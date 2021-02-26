class Group < ApplicationRecord
  belongs_to :game
  has_many :group_memberships
  has_many :users, through: :group_memberships
  has_many :comments, as: :commentable

  alias_attribute :members, :users
end
