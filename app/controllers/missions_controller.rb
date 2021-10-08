class MissionsController < ApplicationController
	before_action :find_mission, only: %i[show edit update destroy]

	def index
		@missions = Mission.all
	end

	def show
	end

	def new
		@mission = Mission.new
	end

	def create
		@mission = Mission.new(mission_params)
		if @mission.save
			redirect_to missions_path, notice: "新增成功"
		else
			render :new, notice: "新增失敗、請確認表單內容填寫是否正確。"
		end
	end

	def edit
	end

	def update
		if @mission.update(mission_params)
			redirect_to missions_path(@mission), notice: "修改成功"	
		else 
			render :edit, notice: "新增失敗、請確認表單內容填寫是否正確。"
		end
	end

	def destroy
		redirect_to missions_path if @mission.destroy
	end

	private
		def mission_params
			params.require(:mission).permit(:title, :content)
		end

		def find_mission
			@mission = Mission.find(params[:id])
		end
end
