class Image < ApplicationRecord
  belongs_to :property

  validates :source, presence: true
end
