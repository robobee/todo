class Project < ActiveRecord::Base
	has_many :tasks, dependent: :destroy
	default_scope -> { order(created_at: :asc) }
	validates :title, presence: true,
					  uniqueness: { case_sensitive: false },
					  length: { maximum: 200 }
end