class HomeController < ApplicationController
	skip_before_filter :joined_family,:only=>[:join_a_family]
	def index
	end

	def join_a_family
		if current_user.family
			redirect_to root_path and return
		end
	end
end
