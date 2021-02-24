class Game < ApplicationRecord
    has_many :groups, dependent: :destroy
    validates :name, presence: true
end
