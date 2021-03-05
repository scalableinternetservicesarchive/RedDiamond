class Thumb < ApplicationRecord
  belongs_to :thumber, class_name: "User"
  belongs_to :thumbable, polymorphic: true
end
