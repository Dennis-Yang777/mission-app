class HomesController < ApplicationController
	layout 'home'
	def index
		if current_user
			redirect_to missions_path
		end
	end
end
