# frozen_string_literal: true

# app/models/user.rb
class User < ApplicationRecord
  has_many :user_viewing_parties
  has_many :viewing_parties, through: :user_viewing_parties

  validates :name, presence: true, format: { with: /\A[A-Za-z -']+\z/ }
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\A([A-Za-z0-9._-]+@[A-Za-z0-9._-]+\.[A-Za-z]{2,})\z/ }
  validates :password, presence: true

  has_secure_password
end
