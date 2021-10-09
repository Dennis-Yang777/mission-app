class MissionsController < ApplicationController
	before_action :authenticate_user!, except: %i[index]
	before_action :find_author_mission, only: %i[show edit update destroy]

	def index
		@missions = Mission.where(user_id: current_user)
	end

	def show
	end

	def new
		@mission = current_user.missions.new
	end

	def create
		@mission = current_user.missions.new(mission_params)
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

		def find_author_mission
			@mission = current_user.missions.find(params[:id])
		end
end
