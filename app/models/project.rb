class Project < ActiveRecord::Base
	has_many :tasks, dependent: :destroy
	validates :title, presence: true,
					  uniqueness: { case_sensitive: false }
end