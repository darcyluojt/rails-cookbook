class Category < ApplicationRecord
  has_many :bookmarks, dependent: :destroy
  has_many :recipes, through: :bookmarks
  validates :name, uniqueness: true
  has_one_attached :category_image
end
