class MissionsController < ApplicationController
	def index
		@missions = Mission.all
	end

	def show
		@mission = Mission.find(params[:id])
	end

	def new
		@mission = Mission.new
	end

	def create
		@mission = Mission.new(mission_params)
		if @mission.save
			redirect_to missions_path, notice: "新增成功"
		else
			render :new, notice: "新增失敗、請確認表單內容填寫是否正確"
		end
	end


	private
		def mission_params
			params.require(:mission).permit(:title, :content)
		end
end
