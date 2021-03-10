class Comment < ApplicationRecord
  belongs_to :commenter, class_name: "User", touch: true
  belongs_to :commentable, polymorphic: true, touch: true
end
