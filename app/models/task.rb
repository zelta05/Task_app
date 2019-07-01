class Task < ApplicationRecord
    
    belongs_to :project
  has_many :comments
  has_many :task_tags

  has_many :user_tasks, foreign_key: "assigned_task_id"
  has_many :assigned_users, through: :user_tasks
  belongs_to :owner, class_name: "User"

  enum status: [:active, :complete]

  validates :name, :description, :due_date, :status, :project_id, presence: true

  scope :complete, -> { where(status: 1) }
  scope :active, -> { where(status: 0)}
  scope :overdue, -> { where("due_date < ? AND status = ?", Date.today, 0)}

  #Custom writer and readers for Task for creating nested attributes

  

  def overdue?
    self.due_date < Date.today ? true : false
  end

end
