class Like < ApplicationRecord
  validates :post_id, presence: true
  validates :user, presence: true, uniqueness: { scope: :post_id }
end
