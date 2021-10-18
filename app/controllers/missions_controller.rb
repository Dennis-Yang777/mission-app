class MissionsController < ApplicationController
	before_action :authenticate_user!
	before_action :find_author_mission, only: %i[edit update destroy change_state]

	def index
		@missions = Mission.user_missions(current_user).desc
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
				redirect_to missions_path, notice: "修改成功"	
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

	def search
		if params[:keyword]
			@missions = Mission.where("title LIKE ? OR content LIKE ?", "%#{params[:keyword]}%", "%#{params[:keyword]}%").desc
			render :index
		else
			@missions = Mission.user_missions(current_user).desc
			render :index
		end
	end

	def state_search
		if params[:state]
			@missions = Mission.where(state: params[:state]).desc
			render :index
		else
			@missions = Mission.user_missions(current_user).desc
			render :index
		end
	end

	def change_state
		case @mission.state
			when "pending"
				@mission.run!
			when "running"
				@mission.finish!
		end
		redirect_to missions_path, notice: '任務狀態更新成功'
	end

	private
		def mission_params
			params.require(:mission).permit(:title, :content, :start_time, :end_time, :priority)
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
