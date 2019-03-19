class User < ApplicationRecord
  enum role: %i[user admin], _prefix: :role

  has_many :tasks, dependent: :destroy

  has_secure_password

  scope :mapped_emails, -> { pluck(:email, :id) }
end
