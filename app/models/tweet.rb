class Tweet < ApplicationRecord
  belongs_to :user

  has_many_attached :documents

  validates :content, presence: true, length: { maximum: 280 }
end
