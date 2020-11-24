class Category < ApplicationRecord

  has_and_belongs_to_many :products

  validates :category_name, presence: true, uniqueness: {case_sensitive: false}
end
