class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true, length: { in: 3..20 }

  has_many :group_memberships
  has_many :groups, through: :group_memberships
  has_many :comments

  def to_param
    username
  end
end
