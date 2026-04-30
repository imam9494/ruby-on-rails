class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # enum role
  enum :role, { user: "user", staff: "staff", admin: "admin" }

  # default role
  after_initialize do
    self.role ||= "user" if new_record?
  end

  # helper
  def admin?
    role == "admin"
  end

  def staff?
    role == "staff"
  end
end
