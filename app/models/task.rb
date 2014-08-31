class Task < ActiveRecord::Base
  belongs_to :project
  default_scope -> { order('created_at ASC') } #add priority ordering
  validates :project_id, presence: true
  validates :name, presence: true, length: { maximum: 200 }
  validates :status, inclusion: { in: %w(New Done), message: "%{value} is not a valid status" }
  validates_each :deadline do |record, attr, value|
    if value && value <= DateTime.now
    then record.errors.add(attr, 'must be in future') 
    end
  end
end