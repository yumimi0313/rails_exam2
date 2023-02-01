class User < ApplicationRecord
  validates :name, presence: true, length: { maximaum:30 }
  validates :email, presence: true, length: { maximaum:255}
  format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
end
