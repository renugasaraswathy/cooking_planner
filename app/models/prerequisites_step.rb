class PrerequisitesStep < ActiveRecord::Base
	belongs_to :recipe
	scope :ordered_by_step_no,->{order('step_no asc')}
end
