class Bookmark < ApplicationRecord
  belongs_to :category
  belongs_to :recipe
  validates :comment, length: { minimum: 6, too_short: "must have more than 6 characters." }
  validates :category_id, uniqueness: { scope: :recipe_id, message: "is already in the list" }
end
