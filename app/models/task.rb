class Task < ActiveRecord::Base
  belongs_to :project
  default_scope -> { order(priority: :asc) } 
  before_save :on_save
  before_validation :on_validation
  validates :project_id, presence: true
  validates :name, presence: true, length: { maximum: 200 }
  validates :status, inclusion: { in: %w(New Done), message: "%{value} is not a valid status" }
  validates_each :deadline do |record, attr, value|
    if value && value <= DateTime.now
    then record.errors.add(attr, 'must be set in future') 
    end
  end

  protected

  	def on_validation
  	  self.status ||= "New"
  	end

	def on_save
	  if self.priority == nil
	  then
	  	max_priority = Task.where("project_id = #{self.project_id}").maximum("priority")
	  	if max_priority == nil
	  	then self.priority = 1
	  	else self.priority = max_priority + 1
		end
	  end
	end
end