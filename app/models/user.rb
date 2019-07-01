class User < ApplicationRecord
  attr_accessor :remember_token
  
  has_many :projects

  has_many :user_projects, foreign_key: "collaborator_id"
  has_many :projects, foreign_key: "owner_id"
  has_many :collaboration_projects, through: :user_projects
  has_many :user_tasks, foreign_key: "assigned_user_id"
  has_many :assigned_tasks, through: :user_tasks
  
  has_many :tasks, foreign_key: "owner_id"

  
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
                       format: { with: VALID_EMAIL_REGEX },
                      uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_blank: true
  
  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Returns true if the given token matches the digest.
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
  
  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end
  
  def all_active_projects
    self.projects.active + self.collaboration_projects
  end

  def active_projects
    self.projects.active 
  end

  def complete_projects
    self.projects.complete
  end

  def overdue_projects
    self.projects.overdue
  end

  def active_tasks
    self.tasks.active 
  end

  def complete_tasks
    self.tasks.complete
  end

  def overdue_tasks
    self.tasks.overdue
  end

  def active_assigned_tasks
    self.assigned_tasks.active 
  end

  def complete_assigned_tasks
    self.assigned_tasks.complete
  end

  def overdue_assigned_tasks
    self.assigned_tasks.overdue
  end

  def collaboration_tags
    self.collaboration_projects.collect {|task| task.tags.collect {|tag| tag}}
end
end
