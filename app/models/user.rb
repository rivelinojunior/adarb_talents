class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  validates :email_address, uniqueness: true
  validates :password, length: { in: 8..20 }
  validates :password_confirmation, length: { in: 8..20 }
end
