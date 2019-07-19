class Post < ApplicationRecord
  acts_as_taggable
  acts_as_commentable
end
