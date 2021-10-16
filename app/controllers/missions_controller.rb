class MissionsController < ApplicationController
	before_action :authenticate_user!
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
		if check_date
			if @mission.save
				redirect_to missions_path, notice: "新增成功"
			else
				render :new, notice: "新增失敗、請確認表單內容填寫是否正確。"
			end
		else
			render :new, notice: "結束日期比開始日期早，請重新填寫"
		end

	end

	def edit
	end

	def update
		if check_date
			if @mission.update(mission_params)
				redirect_to missions_path(@mission), notice: "修改成功"	
			else
				render :edit, notice: "新增失敗、請確認表單內容填寫是否正確。"
			end
		else
			render :edit, notice: "結束日期比開始日期早，請重新填寫"
		end
	end

	def destroy
		redirect_to missions_path if @mission.destroy
	end

	private
		def mission_params
			params.require(:mission).permit(:title, :content, :start_time, :end_time)
		end

		def find_author_mission
			@mission = current_user.missions.find(params[:id])
		end

		def check_date
			start_time = params.require(:mission).permit(:start_time).values.join
			end_time = params.require(:mission).permit(:end_time).values.join
			start_time < end_time
		end
end
