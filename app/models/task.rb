class Task < ActiveRecord::Base
  belongs_to :project
  default_scope -> { order(updated_at: :desc, priority: :asc) } #add priority ordering
  after_initialize :init
  validates :project_id, presence: true
  validates :name, presence: true, length: { maximum: 200 }
  validates :status, inclusion: { in: %w(New Done), message: "%{value} is not a valid status" }
  validates_each :deadline do |record, attr, value|
    if value && value <= DateTime.now
    then record.errors.add(attr, 'must be in future') 
    end
  end
  def init 
  	self.status ||= "New"
  	self.priority ||= 1
  end 
end