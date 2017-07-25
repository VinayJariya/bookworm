class Book < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :author, presence:true
  validates :description, presence: true
  validates :user_id, presence:true

  default_scope -> {order(created_at: :desc)}
end
