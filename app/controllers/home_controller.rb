class HomeController < ApplicationController
	skip_before_filter :joined_family,:only=>[:join_a_family]
	def index
		@today_food_plans=current_user.family.food_plan_for_days(Date.today)
		@tomorrow_food_plans=current_user.family.food_plan_for_days(Date.today.next_day)
		@third_day_food_plans=current_user.family.food_plan_for_days(Date.today.next_day.next_day)

		@planned_dates=current_user.family.food_plans.select(:day).distinct.collect(&:day)
	end

	def join_a_family
		if current_user.family
			redirect_to root_path and return
		end
	end

	def plans_on
		@food_plans=current_user.family.food_plan_for_days(Date.parse(params[:date]))
	end
end
